// from https://matklad.github.io/2025/04/21/fun-zig-program.html
fn f(comptime x: bool) if (x) u32 else bool {
    return if (x) 0 else false;
}

const print = @import("std").debug.print;
pub fn main() void {
    print("{} {}", .{ f(false), f(true) }); // prints "false 0"
}
