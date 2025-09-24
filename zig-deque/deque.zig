const std = @import("std");

pub fn main() !void {
    var da: std.heap.DebugAllocator(.{}) = .init;
    const alloc = da.allocator();
    var q: std.Deque(u32) = .empty;
    defer q.deinit(alloc);

    try q.pushBack(alloc, 1);
    try q.pushBack(alloc, 2);
    try q.pushFront(alloc, 0);

    var it = q.iterator();
    while (it.next()) |el| {
        std.debug.print("{d}\n", .{el});
    }
}
