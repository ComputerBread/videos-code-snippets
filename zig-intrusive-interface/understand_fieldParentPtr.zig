const std = @import("std");

const Bread = struct {
    proteins: u32,
    carbs: u32,
    fat: u16,
    calories: u8,
};

pub fn main() void {
    const mr_bread = Bread{
        .calories = 66,
        .fat = 820,
        .proteins = 1900,
        .carbs = 12650,
    };

    std.debug.print("@ of mr_bread: {*}\n", .{&mr_bread});
    std.debug.print("@ of mr_bread.proteins: {*}\n", .{&mr_bread.proteins});
    std.debug.print("@ of mr_bread.carbs: {*}\n", .{&mr_bread.carbs});
    std.debug.print("@ of mr_bread.fat: {*}\n", .{&mr_bread.fat});
    std.debug.print("@ of mr_bread.calories: {*}\n", .{&mr_bread.calories});
    std.debug.print("offset of mr.fat: {d}\n", .{@offsetOf(Bread, "fat")});
    const addr_prot_from_struct_plus_offset: *u16 = @ptrFromInt(@intFromPtr(&mr_bread) + @offsetOf(Bread, "fat"));
    std.debug.print("@ of mr_bread.fat using offset: {*}\n", .{addr_prot_from_struct_plus_offset});

    std.debug.print("{}\n", .{@intFromPtr(&mr_bread.proteins) == @intFromPtr(&mr_bread)});

    // risky
    const bad_bread: *const Bread = @ptrFromInt(@intFromPtr(&mr_bread.carbs) - 4);
    const bad_carbs: *u32 = @ptrFromInt(@intFromPtr(&mr_bread) + 4);
    const bad_fat: *u16 = @ptrFromInt(@intFromPtr(&mr_bread) + 8);
    const bad_calories: *u8 = @ptrFromInt(@intFromPtr(&mr_bread) + 10);
    std.debug.print("bad  - br: {*}, car: {*}, fat: {*}, cal: {*}\n", .{ bad_bread, bad_carbs, bad_fat, bad_calories });
    // good
    const good_bread: *const Bread = @fieldParentPtr("carbs", &mr_bread.carbs);
    const good_carbs: *u32 = @ptrFromInt(@intFromPtr(&mr_bread) + @offsetOf(Bread, "carbs"));
    const good_fat: *u16 = @ptrFromInt(@intFromPtr(&mr_bread) + @offsetOf(Bread, "fat"));
    const good_calories: *u8 = @ptrFromInt(@intFromPtr(&mr_bread) + @offsetOf(Bread, "calories"));
    std.debug.print("good - br: {*}, car: {*}, fat: {*}, cal: {*}\n", .{ good_bread, good_carbs, good_fat, good_calories });
    // &mr_bread.proteins  == &mr_bread + @offsetOf(Bread, "proteins")
    // &mr_bread.carbs    == &mr_bread + @offsetOf(Bread, "carbs")
    // &mr_bread.fat      == &mr_bread + @offsetOf(Bread, "fat")
    // &mr_bread.calories == &mr_bread + @offsetOf(Bread, "calories");
}
