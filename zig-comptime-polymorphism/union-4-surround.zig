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

    fn surround(self: Shape) void {
        var rec: Rectangle = undefined;
        switch (self) {
            .triangle => |triangle| {
                const min_x: f32 = @min(triangle.p1.x, triangle.p2.x, triangle.p3.x);
                const min_y: f32 = @min(triangle.p1.y, triangle.p2.y, triangle.p3.y);
                const max_x: f32 = @max(triangle.p1.x, triangle.p2.x, triangle.p3.x);
                const max_y: f32 = @max(triangle.p1.y, triangle.p2.y, triangle.p3.y);
                rec = Rectangle{ .x = min_x, .y = min_y, .height = max_y - min_y, .width = max_x - min_x };
            },
            .circle => |circle| {
                rec = Rectangle{ .x = circle.x - circle.radius, .y = circle.y - circle.radius, .height = circle.radius * 2, .width = circle.radius * 2 };
            },
            .square => |square| {
                rec = Rectangle{ .x = square.x - 5, .y = square.y - 5, .height = square.side + 10, .width = square.side + 10 };
            },
            .rectangle => |rectangle| {
                rec = Rectangle{ .x = rectangle.x - 5, .y = rectangle.y - 5, .height = rectangle.height + 10, .width = rectangle.width + 10 };
            },
        }
        rec.draw();
    }
};

pub fn main() void {
    const value = Shape{ .square = Square{ .x = 10, .y = 20, .side = 15 } };
    value.surround();
}
