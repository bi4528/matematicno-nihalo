using MN

using Plots
#namenjeno za izris v terminalu
using SixelTerm

"""
Funkcija, ki izriše 2 grafa nihajnega časa v odvisnosti od energije nihala.
-začetna hitrost je v enem primeru 0.1 rad/s, v drugem pa 0.05 rad/s
- m je masa nihala
- l je dolžina nihala
- n je število korakov
- theta_max je maksimalni kot, do katerega želimo izračunati nihajni čas in energijo
"""
function izrisi_graf(m, l, n, theta_max=π/2)
    # Začetna hitrost 0.1 rad/s
    energija_vals, t_vals = MN.vrni_nihajni_cas_in_energijo(m, l, n, theta_max, 0.1)

    # Izrišemo rezultate za začetno hitrost 0.1 rad/s
    plot(energija_vals, t_vals, label="začetna hitrost 0.1 rad/s")

    # Začetna hitrost 0.4 rad/s
    energija_vals, t_vals = MN.vrni_nihajni_cas_in_energijo(m, l, n, theta_max, 0.4)
    # Izrišemo rezultate za začetno hitrost 0.4 rad/s
    plot!(energija_vals, t_vals, label="začetna hitrost 0.4 rad/s")
    
    xlabel!("Energija (J)")
    ylabel!("Nihajni čas (s)")
    title!("Spreminjanje nihajnega časa z energijo nihala")
    
    #namenjeno za izris v direktorij ./graphs
    #savefig("./graphs/primerjava-dt01.png")
end

# Izrišemo graf nihajnega časa v odvisnosti od energije nihala
# začetna hitrost je v enem primeru 0.1 rad/s, v drugem pa 0.05 rad/s
# masa nihala: 1 kg
# dolžina nihala: 1 m
# število korakov: 1000
izrisi_graf(1, 1, 1000)