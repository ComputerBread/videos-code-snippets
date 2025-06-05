// https://github.com/ghostty-org/ghostty/blob/8a00aa8223dddd490e55b741e4293d8ff1e756df/src/font/face/web_canvas.zig
pub const Face = struct {
    pub fn deinit(self: *Face) void {}

    pub fn setSize(self: *Face, size: font.face.DesiredSize) !void {}

    pub fn renderGlyph(self: Face, alloc: Allocator, atlas: *font.Atlas, glyph_index: u32, opts: font.face.RenderOptions) !font.Glyph {}
};
