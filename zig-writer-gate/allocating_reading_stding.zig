const std = @import("std");

pub fn main() !void {
    var stdin_buffer: [10]u8 = undefined;
    var stdin: std.fs.File = std.fs.File.stdin();
    var stdin_reader: std.fs.File.Reader = stdin.reader(&stdin_buffer);

    var alloc = std.heap.DebugAllocator(.{}).init;
    defer _ = alloc.deinit();
    const da = alloc.allocator();

    var allocating_writer = std.Io.Writer.Allocating.init(da);
    defer allocating_writer.deinit();

    while (stdin_reader.interface.streamDelimiter(&allocating_writer.writer, '\n')) |_| {
        const line = allocating_writer.written();
        std.debug.print("you typed: {s}\n", .{line});
        allocating_writer.clearRetainingCapacity(); // empty the line buffer
        stdin_reader.interface.toss(1); // skip the newline
    } else |err| {
        std.debug.print("an error occured: {any}\n", .{err});
    }
}
