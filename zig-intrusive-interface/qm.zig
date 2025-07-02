const std = @import("std");

fn qm(comptime t: anytype) u8 {
    const t_n: []const u8 = if (@typeInfo(@TypeOf(t)) == .enum_literal)
        @tagName(t)
    else // If it coerces, it works:
        t;
    std.debug.print("type of t: {}\n", .{@TypeOf(t)});
    std.debug.print("type info of t: {}\n", .{@typeInfo(@TypeOf(t))});
    std.debug.print("type name: {s}\n", .{t_n});
    return 1;
}
pub fn main() void {
    // const a: u8 = 8;
    // qm(a);

    const S = struct {
        field: u32,

        const b = qm(.field);
    };

    _ = qm(.next);
    const s = S{ .field = 1 };
    _ = s;
}
