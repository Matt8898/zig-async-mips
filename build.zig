const std = @import("std");
const Builder = std.build.Builder;
const builtin = std.builtin;
const assert = std.debug.assert;

fn target(arch: builtin.Arch) std.zig.CrossTarget {
    var disabled_features = std.Target.Cpu.Feature.Set.empty;
    var enabled_feautres = std.Target.Cpu.Feature.Set.empty;

    if (arch == .mips) {
        const features = std.Target.mips.Feature;
        enabled_feautres.addFeature(@enumToInt(features.mips32r2));
    }

    return std.zig.CrossTarget{
        .cpu_arch = arch,
        .os_tag = std.Target.Os.Tag.freestanding,
        .abi = std.Target.Abi.none,
        .cpu_features_sub = disabled_features,
        .cpu_features_add = enabled_feautres,
    };
}

pub fn build(b: *Builder) void {
    const targ = target(builtin.Arch.mips);

    const kernel = b.addExecutable("zig-async", "test.zig");
    kernel.setTarget(targ);
    kernel.addAssemblyFile("start.S");
    kernel.setBuildMode(.ReleaseSmall);
    kernel.setMainPkgPath("./");
    kernel.setOutputDir(b.cache_root);
    kernel.setLinkerScriptPath("linker.ld");
    kernel.install();
}
