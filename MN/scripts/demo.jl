using MN

using Plots
using SixelTerm

g = 9.80665  # Težni pospešek

function primerjaj_z_harmonicnim_nihalom(l, t, theta0, dtheta0, n)
    # Časi
    times = LinRange(0.0, t, n+1)

    # Nihanje matematičnega nihala
    θ_vals = MN.matematicno_nihalo(l, t, theta0, dtheta0, n)

    # Nihanje harmoničnega nihala
    θ_harmonic = MN.harmonicno_nihalo(l, t, theta0, n)

    # Izrišemo rezultate
    plot(times, θ_vals, label="Matematično nihalo")
    plot!(times, θ_harmonic, label="Harmonično nihanje")
    
    xlabel!("Čas (s)")
    ylabel!("Odmik (rad)")
    title!("Primerjava matematičnega nihala z harmoničnim nihanjem")
end

# Primerjajmo nihanje matematičnega nihala z nihanjem harmoničnega nihala
# dolžina nihala: 1 m
# čas nihanja: 10 s
# začetni kot: 0.1 rad
# začetna hitrost: 0.05 rad/s
# število korakov: 1000
primerjaj_z_harmonicnim_nihalom(1, 10.0, 0.1, 0.0, 1000)

# Primerjajmo nihanje matematičnega nihala z nihanjem harmoničnega nihala
# pričakujemo manjšo napako, saj je začetna hitrost pri harmoničnem nihalu 0.0 rad/s
# dolžina nihala: 1 m
# čas nihanja: 10 s
# začetni kot: 0.1 rad
# začetna hitrost: 0.0 rad/s
# število korakov: 1000
primerjaj_z_harmonicnim_nihalom(1, 10.0, 0.1, 0.0, 1000)



