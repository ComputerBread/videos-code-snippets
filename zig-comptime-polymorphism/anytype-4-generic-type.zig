const std = @import("std");

fn SmthFnBodies(comptime T: type) type {
    return struct {
        foo: fn (T) void,
        bar: fn (T, u32) u32,
    };
}

fn polymorphicFn(
    smth: anytype,
    fns: SmthFnBodies(@TypeOf(smth)),
) void {
    fns.foo(smth);
    std.debug.print("{d}\n", .{fns.bar(smth, 42)});
}

const Smth = struct {
    fn foo(_: Smth) void {
        std.debug.print("foo\n", .{});
    }

    fn bar(_: Smth, nb: u32) u32 {
        return nb * 2;
    }
};

const SmthElse = struct {
    fn foo(_: SmthElse) void {
        std.debug.print("ELSE\n", .{});
    }

    fn bar(_: SmthElse, nb: u32) u32 {
        return nb * 3;
    }
};

pub fn main() void {
    const s = Smth{};
    polymorphicFn(s, .{ .foo = Smth.foo, .bar = Smth.bar });
}
