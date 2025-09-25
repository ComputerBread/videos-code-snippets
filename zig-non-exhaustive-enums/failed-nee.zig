test "missing tag" {
    const Invalid = enum { // ERROR: non-exhaustive enum missing integer tag type
        ok,
        bad_request,
        unauthorized,
        not_found,
        internal_server_error,
        _, // <-- trailing underscore
    };
}

test "non-exhaustive is actually exhaustive" {
    const Invalid = enum(u2) {
        zero,
        one,
        two,
        three,
        _,
    };

    _ = Invalid.zero;
}
