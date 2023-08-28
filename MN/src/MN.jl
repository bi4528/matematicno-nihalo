module MN

using Plots

g = 9.80665  # Težni pospešek

"""
Funkcija za numerično reševanje diferencialnih enačb 2. reda, 
ki opisuje matematično nihalo z metodo Runge-Kutta 4. reda.
- l je dolžina nihala
- t je čas nihanja
- theta0 je začetni kot
- dtheta0 je začetna hitrost
- n je število korakov
"""
function matematicno_nihalo(l, t, theta0, dtheta0, n)
    h = t / n    # Dolžina enega koraka
    
    # Definiramo funkcijo sistema prvega reda
    function f(θ, ω)
        return [ω, -g/l * sin(θ)]
    end
    
    # Začetni pogoji
    θ = theta0
    ω = dtheta0

    # Pripravimo tabelo za shranjevanje rezultatov
    θ_vals = [θ]
    
    # Izračunamo vrednosti za vsak korak z Runge-Kutta 4. reda
    for i in 1:n
        k1 = h * f(θ, ω)
        k2 = h * f(θ + k1[1] / 2, ω + k1[2] / 2)
        k3 = h * f(θ + k2[1] / 2, ω + k2[2] / 2)
        k4 = h * f(θ + k3[1], ω + k3[2])
        
        θ += (k1[1] + 2k2[1] + 2k3[1] + k4[1]) / 6
        ω += (k1[2] + 2k2[2] + 2k3[2] + k4[2]) / 6
        
        push!(θ_vals, θ)
    end
    
    return θ_vals
end

"""
Funkcija, ki vrne vrednosti za harmonično nihanje.
- l je dolžina nihala
- t je čas nihanja
- theta0 je začetni kot
- n je število korakov
"""
function harmonicno_nihalo(l, t, theta0, n)
    times = LinRange(0.0, t, n+1)

    # Nihanje harmoničnega nihala
    return theta0 * cos.(sqrt(g/l) .* times)
end

end # module MN
