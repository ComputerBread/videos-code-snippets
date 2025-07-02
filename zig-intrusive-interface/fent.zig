const Gender = enum {
    male,
    female,
    droid,
    mechanic,
};

const Chat = struct {
    fent: MicrosoftBioSpyware,
    braincells: i32,
    gender: Gender,
};

const MicrosoftBioSpyware = struct {};

const BillGates = struct {
    fent_reactor: [10]*MicrosoftBioSpyware = .{undefined} ** 10,
    fent_i: usize = 0,

    const Self = @This();

    fn append(self: *Self, chat: *Chat) void {
        if (self.fent_i >= 10) unreachable;
        self.fent_reactor[self.fent_i] = &chat.fent;
        self.fent_i += 1;
    }

    fn mindControl(self: Self) void {
        for (0..self.fent_i) |i| {
            var user: *Chat = @alignCast(@fieldParentPtr("fent", self.fent_reactor[i]));
            user.braincells = 0;
            user.gender = .droid;
        }
    }
};

var bill_gates = BillGates{};
fn minecraftLogIn(chat: *Chat) void {
    bill_gates.append(chat);
}

pub fn main() void {
    var chat = Chat{
        .fent = MicrosoftBioSpyware{},
        .braincells = 200,
        .gender = .mechanic,
    };

    std.debug.print("BEFORE fent >>> chat: braincells: {:4}, gender: {}\n", .{ chat.braincells, chat.gender });
    minecraftLogIn(&chat);
    bill_gates.mindControl();
    std.debug.print("AFTER  fent >>> chat: braincells: {:4}, gender: {}\n", .{ chat.braincells, chat.gender });
}

const std = @import("std");
