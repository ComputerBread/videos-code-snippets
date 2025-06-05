const std = @import("std");

fn polymorphicFn(
    smth: anytype,
    comptime foo: fn (@TypeOf(smth)) void,
    comptime bar: fn (@TypeOf(smth), u32) u32,
) void {
    foo(smth);
    _ = bar(smth, 42);
    //std.debug.print("{d}\n", .{bar(smth, 42)});
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
    var a: u32 = 2;
    a += 1;
    if (a == 2) {
        const s = Smth{};
        polymorphicFn(s, Smth.foo, Smth.bar);
        a += 3;
    } else {
        const s = SmthElse{};
        polymorphicFn(s, SmthElse.foo, SmthElse.bar);
        a += 2;
    }
}
