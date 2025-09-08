const std = @import("std");

const Writer = struct {
    vtable: VTable,
    fn write(w: *Writer, bytes: []const u8) void {
        w.vtable.drain(w, bytes, 1);
    }
    const VTable = struct {
        drain: *const fn (*Writer, []const u8, usize) void,
    };
};

const Impl = struct {
    buffer: []u8,
    end: usize,
    writer: Writer,

    fn drain(writer: *Writer, bytes: []const u8, splat: usize) void {
        _ = splat;
        const impl: *Impl = @fieldParentPtr("writer", writer);
        if (impl.end + bytes.len <= impl.buffer.len) {
            @branchHint(.likely);
            @memcpy(impl.buffer[impl.end..][0..bytes.len], bytes);
            impl.end += bytes.len;
        }
        impl.end = 0;
        std.debug.print("{s}{s}", .{ impl.buffer[0..impl.end], bytes });
    }
};

fn writeStuff(w: *Writer) void {
    for (0..10) |_| {
        w.write("stuff\n");
    }
}

pub fn main() void {
    var buf: [15]u8 = undefined;
    var w = Impl{
        .end = 0,
        .buffer = &buf,
        .writer = .{
            .vtable = .{
                .drain = Impl.drain,
            },
        },
    };
    writeStuff(&w.writer);
}
