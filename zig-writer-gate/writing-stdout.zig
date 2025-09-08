const std = @import("std");

pub fn main() !void {

    // Release note: Please use buffering! and don't forget to flush!!!
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer: std.fs.File.Writer = std.fs.File.stdout().writer(&stdout_buffer);
    // we take a pointer, because, that's what the function needs (use @fieldParentPtr)!
    const stdout: *std.Io.Writer = &stdout_writer.interface;

    for (1..1_000_001) |i| {
        try stdout.print("{d}. Hello \n", .{i});
    }

    // don't forget to flush
    try stdout.flush();
}
