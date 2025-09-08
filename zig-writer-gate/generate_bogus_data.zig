const std = @import("std");

pub fn main() !void {
    // Initialize random number generator
    var prng = std.Random.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();

    // Create the output file
    const file = try std.fs.cwd().createFile("bogus_data.txt", .{});
    defer file.close();

    var buf: [1024]u8 = undefined;
    var writer = file.writer(&buf);

    const num_values = 3000;
    for (0..num_values) |_| {
        var value: u8 = '?';

        // 40% chance of '?', 60% chance of random character
        if (rand.float(f32) > 0.4) {
            value = 'a' + rand.intRangeAtMost(u8, 0, 25);
        }

        // Write the value to file
        try writer.interface.print("{c}", .{value});
    }

    try writer.interface.flush();
    std.debug.print("Successfully generated bogus_data.txt with {d} values\n", .{num_values});
}
