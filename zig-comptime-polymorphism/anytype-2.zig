const std = @import("std");

fn polymorphicFn(smth: anytype) void {
    smth.foo();
    _ = smth.bar(42);
}

const Smth = struct {
    fn foo(_: Smth) void {
        std.debug.print("foo\n", .{});
    }

    fn bar(_: Smth, nb: u32) u32 {
        return nb * 2;
    }
};

pub fn main() void {
    const s = Smth{};
    polymorphicFn(s);
}
