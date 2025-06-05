const std = @import("std");
const Triangle = @import("./shapes.zig").Triangle;
const Circle = @import("./shapes.zig").Circle;
const Square = @import("./shapes.zig").Square;
const Rectangle = @import("./shapes.zig").Rectangle;

const ShapeTag = enum {
    triangle,
    circle,
    square,
    rectangle,
};
const Shape = union(ShapeTag) {
    triangle: Triangle,
    circle: Circle,
    square: Square,
    rectangle: Rectangle,
};

pub fn main() void {
    const value = Shape{ .square = Square{ .x = 10, .y = 20, .side = 15 } };
    switch (value) {
        .square => std.debug.print("SQUARE\n", .{}),
        else => std.debug.print("Something ELSE\n", .{}),
    }
    std.debug.print("{d}\n", .{value.square.side});
}
