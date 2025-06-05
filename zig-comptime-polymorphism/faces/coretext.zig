// https://github.com/ghostty-org/ghostty/blob/8a00aa8223dddd490e55b741e4293d8ff1e756df/src/font/face/coretext.zig
pub const Face = struct {

    pub fn init(lib: font.Library, source: [:0]const u8, opts: font.face.Options) !Face {}

    pub fn deinit(self: *Face) void {}

    pub fn syntheticBold(self: *const Face, opts: font.face.Options) !Face {}

    pub fn syntheticItalic(self: *const Face, opts: font.face.Options) !Face {}

    pub fn name(self: *const Face, buf: []u8) Allocator.Error![]const u8 {}

    pub fn setSize(self: *Face, opts: font.face.Options) !void {}

    pub fn setVariations(self: *Face, vs: []const font.face.Variation, opts: font.face.Options) !void {}

    pub fn hasColor(self: *const Face) bool {}

    pub fn isColorGlyph(self: *const Face, glyph_id: u32) bool {}

    pub fn glyphIndex(self: Face, cp: u32) ?u32 {}

    pub fn renderGlyph(self: Face, alloc: Allocator, atlas: *font.Atlas, glyph_index: u32, opts: font.face.RenderOptions) !font.Glyph {}

    pub fn getMetrics(self: *Face) GetMetricsError!font.Metrics.FaceMetrics {}

    pub fn copyTable(self: Face, alloc: Allocator, tag: *const [4]u8) Allocator.Error!?[]u8 {}


};
