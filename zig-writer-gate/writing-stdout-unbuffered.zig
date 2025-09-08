const std = @import("std");

pub fn main() !void {
    var stdout_writer = std.fs.File.stdout().writer(&.{});
    // we take a pointer, because, that's what the functions need
    const stdout = &stdout_writer.interface;

    for (1..1_000_001) |i| {
        try stdout.print("{d}. Hello \n", .{i});
    }

    // don't need to flush anymore
    // try stdout.flush();
}
