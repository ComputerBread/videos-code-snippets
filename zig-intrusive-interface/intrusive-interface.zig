const std = @import("std");

const IntrusiveInterface = struct {
    behavior1Fn: *const fn (ptr: *IntrusiveInterface) void,
    behavior2Fn: *const fn (ptr: *IntrusiveInterface, arg: u32) void,

    pub fn behavior1(self: *IntrusiveInterface) void {
        self.behavior1Fn(self);
    }

    pub fn behavior2(self: *IntrusiveInterface, arg: u32) void {
        self.behavior2Fn(self, arg);
    }
};

const ConcreteType = struct {
    interface: IntrusiveInterface,
    data: u32,

    fn behavior1Fn(ptr: *IntrusiveInterface) void {
        const self: *ConcreteType = @fieldParentPtr("interface", ptr);
        std.debug.print("data: {d}\n", .{self.data});
    }

    fn behavior2Fn(ptr: *IntrusiveInterface, arg: u32) void {
        const self: *ConcreteType = @fieldParentPtr("interface", ptr);
        self.data = arg;
    }
};

pub fn main() void {
    var crew_mate = ConcreteType{
        .interface = .{
            .behavior1Fn = ConcreteType.behavior1Fn,
            .behavior2Fn = ConcreteType.behavior2Fn,
        },
        .data = 10,
    };
    var among_us: *IntrusiveInterface = &crew_mate.interface;
    for (0..11) |i| {
        among_us.behavior2(@as(u32, @intCast(i)) * 10);
        among_us.behavior1();
    }
}
