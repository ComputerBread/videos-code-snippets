const std = @import("std");

pub fn main() !void {
    var user = User{
        .id = 1,
        .power = 9000,
    };
    std.debug.print("address of user: {*}\n", .{&user});

    const address_of_power = &user.power;
    std.debug.print("address of power: {*}\n", .{address_of_power});

    const power_offset = @offsetOf(User, "power");
    const also_user: *User = @ptrFromInt(@intFromPtr(address_of_power) - power_offset);
    std.debug.print("address of also_user: {*}\n", .{also_user});

    std.debug.print("also_user: {}\n", .{also_user});
}

const User = struct {
    id: i64,
    power: u32,
};
