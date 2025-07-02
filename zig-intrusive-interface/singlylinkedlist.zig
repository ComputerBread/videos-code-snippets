const std = @import("std");

// example a bunch of tasks with an order!
const T = struct {
    data: u32,
    node: std.SinglyLinkedList.Node = .{},
};

pub fn main() void {
    var one: T = .{ .data = 1, .node = .{} };
    var two: T = .{ .data = 2 };
    var thr: T = .{ .data = 3 };
    var fou: T = .{ .data = 4 };
    var fiv: T = .{ .data = 5 };

    var list: std.SinglyLinkedList = .{};
    list.prepend(&fou.node); // 4
    fou.node.insertAfter(&fiv.node); // 4, 5
    list.prepend(&thr.node); // 3, 4, 5
    list.prepend(&one.node); // 1, 3, 4, 5
    one.node.insertAfter(&two.node);

    var it = list.first;
    var nb_of_nodes: u32 = 0;
    while (it) |node| : (it = node.next) {
        nb_of_nodes += 1;
        const t: *T = @fieldParentPtr("node", node);
        t.data += 1;
        std.debug.print("task: {d}\n", .{t.data});
        t.data -= 1;
    }
    std.debug.print("nb of nodes: {d}\n", .{nb_of_nodes});

    std.debug.print("thr.data: {d}\n", .{one.data});
    const field_ptr: *std.SinglyLinkedList.Node = &one.node;
    const d_struct_ptr: *T = @fieldParentPtr("node", field_ptr);
    d_struct_ptr.data = 10;
    std.debug.print("thr.data: {d}\n", .{one.data});
}
