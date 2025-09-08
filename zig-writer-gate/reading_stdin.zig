const std = @import("std");

pub fn main() !void {
    var stdin_buffer: [1024]u8 = undefined;
    var stdin: std.fs.File = std.fs.File.stdin();
    var stdin_reader: std.fs.File.Reader = stdin.reader(&stdin_buffer);
    const stdin_ioreader: *std.Io.Reader = &stdin_reader.interface;

    while (stdin_ioreader.takeByte()) |char| {
        if (char == '\n') continue;
        std.debug.print("you typed: {c}\n", .{char});
        if (char == 'q') break;
    } else |err| {
        std.debug.print("an error occured: {any}", .{err});
    }
}
