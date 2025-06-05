const std = @import("std");

pub const Vec2 = struct {
    x: f32,
    y: f32,
};

pub const Rectangle = struct {
    x: f32,
    y: f32,
    width: f32,
    height: f32,

    pub fn draw(self: @This()) void {
        std.debug.print("drawing {s}\n", .{@typeName(@TypeOf(self))});
    }
};
// ------------------------------------------------------------------------------
pub const Square = struct {
    x: f32,
    y: f32,
    side: f32,

    pub fn draw(self: @This()) void {
        std.debug.print("drawing {s}\n", .{@typeName(@TypeOf(self))});
    }
};
// ------------------------------------------------------------------------------
pub const Triangle = struct {
    p1: Vec2,
    p2: Vec2,
    p3: Vec2,

    pub fn draw(self: @This()) void {
        std.debug.print("drawing {s}\n", .{@typeName(@TypeOf(self))});
    }
};
// ------------------------------------------------------------------------------
pub const Circle = struct {
    x: f32, // X position of the center
    y: f32, // Y position of the center
    radius: f32, // Radius of the circle

    pub fn draw(self: @This()) void {
        std.debug.print("drawing {s}\n", .{@typeName(@TypeOf(self))});
    }
};
