const std = @import("std");

const Stuff = struct {
    doStuffFn: *const fn (ptr: *Stuff, quantity: u32) void,

    pub fn doStuff(self: *Stuff, quantity: u32) void {
        self.doStuffFn(self, quantity);
    }
};

const GoodStuff = struct {
    stuff: Stuff,

    did_stuff: bool = false,
    name: []const u8 = "fent",

    // this function needs to have the same signature as the function ptr
    fn doStuffFn(ptr: *Stuff, quantity: u32) void {
        // here, ptr will corresond to GoodStuff.stuff
        // but we want to get the concrete type (GoodStuff)
        // so we use:
        const g_stuff: *GoodStuff = @fieldParentPtr("stuff", ptr);
        g_stuff.did_stuff = true;
        std.debug.print("quantity of {s}: {d}\n", .{ g_stuff.name, quantity });
    }
};
const MidStuff = struct {
    data: i32 = 0,
    fn doStuffFn(ptr: *Stuff, quantity: u32) void {
        const b_stuff: *MidStuff = @fieldParentPtr("stuff", ptr);
        b_stuff.data -= quantity;
    }
};
const BadStuff = struct {
    data: u32 = 0,
    fn doStuffFn(ptr: *Stuff, quantity: u32) void {
        const b_stuff: *BadStuff = @fieldParentPtr("stuff", ptr);
        b_stuff.data += quantity;
    }
};

pub fn main() void {
    var g: GoodStuff = GoodStuff{
        .stuff = .{
            .doStuffFn = GoodStuff.doStuffFn,
        },
    };
    var stuff = &g.stuff;
    stuff.doStuff(100);
}
