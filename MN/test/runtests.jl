using Test, MN

@testset "MN" begin
    # Primerjajmo nihanje matematičnega nihala z nihanjem harmoničnega nihala
    # pod istimi pogoji, saj je začetna hitrost pri harmoničnem nihalu 0.0 rad/s
    @test all(MN.matematicno_nihalo(1, 10.0, 0.1, 0.0, 1000) - MN.harmonicno_nihalo(1, 10.0, 0.1, 1000) .< 1e-1)
end