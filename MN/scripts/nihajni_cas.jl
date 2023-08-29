using MN

using Plots
#namenjeno za izris v terminalu
using SixelTerm
using Elliptic

g = 9.80665  # Težni pospešek

function vrni_maksimalno_theta(l, theta0, dtheta0)
    
    return acos(cos(theta0)-(l/2*g)*dtheta0^2)
end

function izracunaj_nihalni_cas(l, theta0, dtheta0)
    
    theta_max = vrni_maksimalno_theta(l, theta0, dtheta0)
    
    return 4*sqrt(l/g)*Elliptic.F(π/2, sin(theta_max/2)^2)
end

function energija(m, l, theta0, dtheta0)
    
    return m*(g*l*(1-cos(theta0))+0.5*l^2*dtheta0^2)
end

function vrni_nihajni_cas_in_energijo(m, l, n, theta_max, dtheta0)
    
    theta = LinRange(0.0, theta_max, n+1)
    t_vals = []
    energija_vals = []
    for i in 1:n
        push!(t_vals, izracunaj_nihalni_cas(l, theta[i], dtheta0))
        push!(energija_vals, energija(m, l, theta[i], dtheta0))
    end
    
    return energija_vals, t_vals
end

function izrisi_graf(m, l, n, theta_max=π/2)
    # Začetna hitrost 0.1 rad/s
    energija_vals, t_vals = vrni_nihajni_cas_in_energijo(m, l, n, theta_max, 0.1)

    # Izrišemo rezultate za začetno hitrost 0.1 rad/s
    plot(energija_vals, t_vals, label="začetna hitrost 0.1 rad/s")

    # Začetna hitrost 0.05 rad/s
    energija_vals, t_vals = vrni_nihajni_cas_in_energijo(m, l, n, theta_max, 0.05)
    # Izrišemo rezultate za začetno hitrost 0.05 rad/s
    plot!(energija_vals, t_vals, label="začetna hitrost 0.05 rad/s")
    
    xlabel!("Energija (J)")
    ylabel!("Nihajni čas (s)")
    title!("Spreminjanje nihajnega časa z energijo nihala")
    
    #namenjeno za izris v direktorij ./graphs
    #savefig("./graphs/primerjava-dt01.png")
end

izrisi_graf(1, 1, 1000)