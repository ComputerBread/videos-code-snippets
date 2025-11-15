const std = @import("std");
const test_functions = @import("builtin").test_functions;

pub fn main() !void {
    var buffer: [1024]u8 = undefined;
    var out: std.fs.File.Writer = std.fs.File.stdout().writer(&buffer);

    for (test_functions) |t| {
        t.func() catch |err| {
            try out.interface.print("{s} fail: {}\n", .{ t.name, err });
            continue;
        };
        try out.interface.print("{s} passed\n", .{t.name});
    }
    try out.interface.flush();
}
