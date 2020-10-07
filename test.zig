var ind = @intToPtr(*volatile u32, ((0x81000000)));

export fn main() void {
    ind.* = 0;
    _ = async amain();
    while (true) {}
}

fn amain() void {
    ind.* = 1;
    var frame = async func();
    ind.* = 3;

    ind.* = 4;
    resume frame;
    ind.* = 6;
    await frame;
    ind.* = 7;
    while (true) {}
}

fn func() void {
    ind.* = 2;
    suspend;
    ind.* = 5;
}
