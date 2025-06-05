const std = @import("std");

// from https://www.reddit.com/r/Zig/comments/1kud3tl/comptime_interfaces_in_zig/

pub fn createInterface(comptime impls: []const type) type {
    const ret = struct {
        const Self = @This();

        // creates an enum
        const E = blk: {
            var fields: [impls.len]std.builtin.Type.EnumField = undefined;
            for (0.., impls, &fields) |i, impl, *field| {
                field.name = @typeName(impl);
                field.value = i;
            }

            break :blk @Type(.{ .@"enum" = .{
                .tag_type = u32,
                .fields = &fields,
                .decls = &.{},
                .is_exhaustive = true,
            } });
        };

        // create the union using the enum created previously
        const U = blk: {
            var fields: [impls.len]std.builtin.Type.UnionField = undefined;
            for (impls, &fields) |impl, *field| {
                field.name = @typeName(impl);
                field.type = impl;
                field.alignment = 0;
            }

            break :blk @Type(.{
                .@"union" = .{
                    .layout = .auto,
                    .tag_type = E,
                    .fields = &fields,
                    .decls = &.{},
                },
            });
        };

        // the tagged union
        u: U,

        pub fn init(impl: anytype) Self {
            return .{
                .u = @unionInit(U, @typeName(@TypeOf(impl)), impl),
            };
        }

        pub fn do(self: *Self) void {
            const info = @typeInfo(U);
            const tag: E = self.u;
            inline for (info.@"union".fields) |f| {
                if (@field(E, f.name) == tag) {
                    return @field(self.u, f.name).do();
                }
            }
        }
    };

    return ret;
}

// ---------------------------------------------------------------------------

pub fn User(comptime Interface: type) type {
    return struct {
        const Self = @This();

        const ArrayList = std.ArrayList(*Interface);

        arr: ArrayList,

        pub fn init(allocator: std.mem.Allocator) Self {
            return .{ .arr = ArrayList.init(allocator) };
        }

        pub fn deinit(self: *Self) void {
            self.arr.deinit();
        }

        pub fn add(self: *Self, interface: *Interface) !void {
            try self.arr.append(interface);
        }

        pub fn do_all(self: *Self) void {
            for (self.arr.items) |interface| {
                interface.do();
            }
        }
    };
}

// ---------------------------------------------------------------------------
const user = @import("lib").user;
const interface = @import("lib").interface;

const Impl1 = struct {
    x: i32,
    fn do(self: *Impl1) void {
        std.debug.print("Hello world {}\n", .{self.x});
        self.x += 1;
    }
};

const Impl2 = struct {
    fn do(_: *Impl2) void {
        std.debug.print("Goodbye world\n", .{});
    }
};

const Interface = interface.createInterface(&.{ Impl1, Impl2 });
const User = user.User(Interface);

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var u = User.init(allocator);
    defer u.deinit();

    var interface = Interface.init(Impl1{ .x = 1 });
    var interface2 = Interface.init(Impl2{});
    try u.add(&interface);
    try u.add(&interface2);

    u.do_all();
    u.do_all();
}
