const std = @import("std");

test "Succeeding" {
    try std.testing.expect(true);
}

test "Failing" {
    try std.testing.expect(false);
}

test { // nameless success
    try std.testing.expect(true);
}

test { // nameless failure
    try std.testing.expect(false);
}

// test "Leaking" {
//     var list = std.array_list.Managed(u21).init(std.testing.allocator);
//     // missing `defer list.deinit();`
//     try list.append('☔');
//     try std.testing.expect(list.items.len == 1);
// }
