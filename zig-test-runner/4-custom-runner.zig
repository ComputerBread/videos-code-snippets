const std = @import("std");
const builtin = @import("builtin");

pub fn main() !void {
    var success_counter: u32 = 0;
    var failure_counter: u32 = 0;

    for (builtin.test_functions) |t| {
        t.func() catch |err| {
            failure_counter += 1;
            std.debug.print("Test '{s}' failed.\n\t{}\n", .{ t.name, err });
            if (@errorReturnTrace()) |trace| {
                std.debug.dumpStackTrace(trace.*);
            }
            continue;
        };
        success_counter += 1;
        std.debug.print("Test '{s}' succeeded.\n", .{t.name});
    }
    std.debug.print("Test results:\n\t{d} passed\n\t{d} failed\n", .{ success_counter, failure_counter });
}
