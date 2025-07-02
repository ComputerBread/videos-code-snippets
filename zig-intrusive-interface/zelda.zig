pub fn singlyLinkedList(Node: type, comptime next_name: anytype) type {
    // String-ify potential enum literal:
    const next: []const u8 = if (@typeInfo(@TypeOf(next_name)) == .enum_literal)
        @tagName(next_name)
    else // If it coerces, it works:
        next_name;

    // verifyFieldType(Node, next);

    return struct {
        //| Node functions

        pub const ThisNode = @This(); // Needed for calling declarations in SinglyLinkedList

        pub fn insertAfter(node: *Node, new_node: *Node) void {}

        pub fn removeNext(node: *Node) ?*Node {}

        pub fn swap(node: *Node) ?*Node {}

        pub fn findLast(node: *Node) *Node {}

        pub fn countChildren(node: *const Node) usize {}

        pub fn reverse(indirect: *?*Node) void {}

        //| Singly Linked List container type
        pub const SinglyLinkedList = struct {
            first: ?*Node,

            pub const empty: SinglyLinkedList = .{ .first = null };

            pub fn init(first: ?*Node) SinglyLinkedList {}
            pub fn prepend(list: *SinglyLinkedList, new_node: *Node) void {}
            pub fn append(list: *SinglyLinkedList, new_node: *Node) void {}
            pub fn remove(list: *SinglyLinkedList, node: *Node) void {}
            pub fn popFirst(list: *SinglyLinkedList) ?*Node {}
            pub fn len(list: SinglyLinkedList) usize {}
        };
    };
}
