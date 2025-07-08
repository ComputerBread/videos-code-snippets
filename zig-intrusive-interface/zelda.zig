// HOW TO COMPILE THIS:
// 1. create new project with `zig init`
// 2. delete src/root.zig
// 3. `zig fetch --save https://github.com/mnemnion/zelda/archive/refs/tags/v0.1.0.tar.gz`
// 4. replace content of build.zig with:
// ```zig
// const std = @import("std");
//
// pub fn build(b: *std.Build) void {
//     const target = b.standardTargetOptions(.{});
//     const optimize = b.standardOptimizeOption(.{});
//     const exe_mod = b.createModule(.{ .root_source_file = b.path("src/main.zig"), .target = target, .optimize = optimize });
//     const zelda = b.dependency("zelda", .{ .target = target, .optimize = optimize });
//     const zelda_mod = zelda.module("zelda");
//     exe_mod.addImport("zelda", zelda_mod);
//     const exe = b.addExecutable(.{ .name = "z", .root_module = exe_mod });
//     b.installArtifact(exe);
//     const run_cmd = b.addRunArtifact(exe);
//     run_cmd.step.dependOn(b.getInstallStep());
//     if (b.args) |args| {
//         run_cmd.addArgs(args);
//     }
//     const run_step = b.step("run", "Run the app");
//     run_step.dependOn(&run_cmd.step);
// }
// ````
// 5. put content of this file inside src/main.zig
// 6. run `zig build run`
const zelda = @import("zelda");
const std = @import("std");

const T = struct {
    data: u32,

    next: ?*@This() = null,
    pub usingnamespace zelda.singlyLinkedList(@This(), .next);
};

fn iterate(list: T.SinglyLinkedList) void {
    var it = list.first;
    var nb_of_nodes: u32 = 0;
    while (it) |node| : (it = node.next) {
        nb_of_nodes += 1;
        std.debug.print("node before: {d}", .{node.data});
        node.data *= 10;
        std.debug.print("node after: {d}\n", .{node.data});
    }
    std.debug.print("number of nodes: {d}\n", .{nb_of_nodes});
}

pub fn main() !void {
    var list: T.SinglyLinkedList = .empty;

    var one: T = .{ .data = 1 };
    var two: T = .{ .data = 2 };
    var thr: T = .{ .data = 3 };
    var fou: T = .{ .data = 4 };
    var fiv: T = .{ .data = 5 };

    list.prepend(&two); // {2}
    two.insertAfter(&fiv); // {2, 5}
    list.prepend(&one); // {1, 2, 5}
    two.insertAfter(&thr); // {1, 2, 3, 5}
    thr.insertAfter(&fou); // {1, 2, 3, 4, 5}
    iterate(list);
}
