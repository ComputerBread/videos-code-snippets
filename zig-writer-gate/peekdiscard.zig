//  WARN: BEFORE RUNNING THIS FILE:
//        make sure thate "bogus_data.txt" exists,
//        if it doesn't, run generate_bogus_data.zig
//
const std = @import("std");

pub fn main() !void {
    var file: std.fs.File = try std.fs.cwd().openFile("./bogus_data.txt", .{ .mode = .read_only });
    var buffer: [1024]u8 = undefined;
    var file_r: std.fs.File.Reader = file.reader(&buffer);

    var r_buf: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&r_buf);

    var discard_writer = std.Io.Writer.Discarding.init(&.{});

    while (file_r.interface.peekByte()) |char| switch (char) {
        '?' => try file_r.interface.streamExact(&discard_writer.writer, 1),
        else => try file_r.interface.streamExact(&stdout_writer.interface, 1),
    } else |err| switch (err) {
        error.EndOfStream => {
            try stdout_writer.interface.flush();
            std.debug.print("\n{d} bytes discarded\n", .{discard_writer.fullCount()});
        },
        else => std.debug.print("An error occured: {any}", .{err}),
    }
}
