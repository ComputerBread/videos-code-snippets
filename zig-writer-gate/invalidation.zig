const std = @import("std");

pub fn main() !void {
    var stdin_buffer: [10]u8 = undefined;
    var stdin: std.fs.File = std.fs.File.stdin();
    var stdin_reader: std.fs.File.Reader = stdin.reader(&stdin_buffer);

    const c = try stdin_reader.interface.takeArray(5);
    while (stdin_reader.interface.takeArray(5)) |str| {
        for (str, 0..) |char, i| {
            if (char == '\n' or char == ' ') str[i] = '_';
        }
        std.debug.print("slice: {s}, you typed: {s}\n", .{ c, str });
    } else |err| {
        std.debug.print("an error occured: {any}", .{err});
    }
}
