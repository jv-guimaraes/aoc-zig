const std = @import("std");
const input = @embedFile("input.txt");
const IntegerBitSet = std.bit_set.IntegerBitSet;

fn priority(char: u8) u8 {
    return switch (char) {
        97...122 => char - 96,
        else => char - 38,
    };
}

fn shared_item(sack: []const u8) ?u8 {
    const len = sack.len;
    var first_half = IntegerBitSet(123).initEmpty();
    for (sack[0 .. len / 2]) |char| {
        first_half.set(char);
    }

    for (sack[len / 2 ..]) |char| {
        if (first_half.isSet(char)) {
            return char;
        }
    }

    return null;
}

pub fn main() !void {
    var lines = std.mem.tokenize(u8, input, "\r\n");
    var sum: u32 = 0;
    while (lines.next()) |line| {
        const item = shared_item(line).?;
        sum += priority(item);
    }
    std.debug.print("Part 1: {}", .{sum});
}
