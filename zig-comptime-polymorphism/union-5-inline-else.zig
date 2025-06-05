const std = @import("std");
const Triangle = @import("./shapes.zig").Triangle;
const Circle = @import("./shapes.zig").Circle;
const Square = @import("./shapes.zig").Square;
const Rectangle = @import("./shapes.zig").Rectangle;

const Shape = union(enum) {
    triangle: Triangle,
    circle: Circle,
    square: Square,
    rectangle: Rectangle,

    fn draw(self: Shape) void {
        switch (self) {
            inline else => |shape| shape.draw(),
        }
    }
};

pub fn main() void {
    const value = Shape{ .square = Square{ .x = 10, .y = 20, .side = 15 } };
    value.draw();
}
