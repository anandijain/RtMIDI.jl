# code from https://github.com/JuliaGraphics/FreeType.jl/tree/master/gen

using Clang.Generators
using rtmidi_jll

const rtmidi_dir = normpath(rtmidi_jll.find_artifact_dir(), "include/rtmidi")
((root, dirs, files),) = walkdir(rtmidi_dir)
const headers = normpath.(root, filter(x -> endswith(x, ".h"), files))
const args = vcat(get_default_args()) # "-I$rtmidi_dir"
const options = load_options(joinpath(@__DIR__, "generator.toml"))

ctx = create_context(headers, args, options)

build!(ctx)
