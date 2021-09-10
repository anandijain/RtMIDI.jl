using RtMIDI, Test

@testset "RtMIDI Tests" begin
    @testset "symbols" begin include("dlsym.jl") end
end