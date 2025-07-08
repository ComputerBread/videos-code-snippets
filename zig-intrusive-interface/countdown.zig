// claude generated
const std = @import("std");
const print = std.debug.print;
const sleep = std.time.sleep;

pub fn main() !void {
    var gpa: std.heap.DebugAllocator(.{}) = .init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len != 2) {
        print("Usage: {s} <number>\n", .{args[0]});
        return;
    }

    const start_num = std.fmt.parseInt(i32, args[1], 10) catch |err| {
        print("Error: Invalid number '{s}' - {}\n", .{ args[1], err });
        return;
    };

    if (start_num < 0) {
        print("Error: Number must be non-negative\n", .{});
        return;
    }

    var i: i32 = start_num;
    while (i >= 0) : (i -= 1) {
        // Clear screen using ANSI escape sequence
        print("\x1b[2J\x1b[H", .{});
        // Print the current number
        print("{d}\n", .{i});
        // Sleep for 1 second (1 billion nanoseconds)
        sleep(100_000_000);
    }
}
