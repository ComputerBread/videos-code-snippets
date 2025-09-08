const std = @import("std");

pub fn main() !void {
    var stdin_buffer: [10]u8 = undefined;
    var stdin: std.fs.File = std.fs.File.stdin();
    var stdin_reader: std.fs.File.Reader = stdin.reader(&stdin_buffer);

    while (stdin_reader.interface.takeArray(20)) |str| {
        std.debug.print("you typed: {s}\n", .{str});
    } else |err| {
        std.debug.print("an error occured: {any}", .{err});
    }
}
