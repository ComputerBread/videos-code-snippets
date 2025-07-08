// inspired by https://ziglang.org/documentation/0.14.1/std/#src/std/array_list.zig
var list = ArrayList(i32).init(std.testing.allocator);
defer list.deinit();
try list.append(1);
try list.append(2);
try list.append(3);
try list.append(4);
try list.append(5);

// https://ziglang.org/documentation/0.14.1/std/#src/std/hash_map.zig
var map = AutoHashMap(u32, u32).init(std.testing.allocator);
defer map.deinit();
try map.put(1, 1);
try map.put(2, 2);
try map.put(3, 3);
try map.put(4, 4);
try map.put(5, 5);

// https://ziglang.org/documentation/0.14.1/std/#src/std/priority_queue.zig
fn greaterThan(context: void, a: u32, b: u32) Order {
    return lessThan(context, a, b).invert();
}
var queue = PriorityQueue(u32, void, greaterThan).init(testing.allocator, {});
defer queue.deinit();
try queue.add(1);
try queue.add(2);
try queue.add(3);
try queue.add(4);
try queue.add(5);
