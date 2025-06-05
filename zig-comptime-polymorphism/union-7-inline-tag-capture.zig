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
            inline else => |shape, tag| {
                if (tag == .triangle) {
                    std.debug.print("extra work with triangle\n", .{});
                }
                shape.draw();
            },
        }
    }
};

pub fn main() void {
    const value = Shape{ .triangle = Triangle{
        .p1 = .{ .x = 1, .y = 2 },
        .p2 = .{ .x = 20, .y = 20 },
        .p3 = .{ .x = 10, .y = 40 },
    } };
    value.draw();
}
