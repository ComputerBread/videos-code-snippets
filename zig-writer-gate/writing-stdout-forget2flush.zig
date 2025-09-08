const std = @import("std");

pub fn main() !void {
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer: std.fs.File.Writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout: *std.Io.Writer = &stdout_writer.interface;
    //            ^ we take a pointer, because that's what the functions need

    for (1..1001) |i| {
        try stdout.print("{d}. Hello \n", .{i});
    }

    // forget to flush
    // try stdout.flush();
}
