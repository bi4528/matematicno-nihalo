# Numerično nihanje nihala

## Uvod
Ta dokument opisuje numerično reševanje diferencialne enačbe drugega reda, ki opisuje nihanje matematičnega nihala. Naloga vključuje prevedbo diferencialne enačbe drugega reda na sistem dveh diferencialnih enačb prvega reda ter numerično reševanje tega sistema z uporabo Runge-Kutta metode četrtega reda. Cilj je primerjati numerično rešitev z analitično rešitvijo za harmonično nihanje. Vključuje dodatne funkcije za izračun maksimalnega kota, nihalnega časa ter energije nihala v odvisnosti od začetnih pogojev.

## Diferencialna enačba in prevedba na sistem prvega reda
Diferencialna enačba, ki opisuje kotni odmik $\theta(t)$ pri nedušenem nihanju nitnega nihala, je podana kot:
```math
\frac{g}{l}\sin(\theta(t)) + \theta(t) = 0
```
kjer sta $g$ težni pospešek in $l$ dolžina nihala.

Da bi to diferencialno enačbo rešili numerično, jo najprej prevedemo na sistem dveh diferencialnih enačb prvega reda:
```math
\theta'(t) = \omega(t)
```
```math
\omega'(t) = -\frac{g}{l}\sin(\theta(t))
```
kjer je $\theta'(t)$ kotna hitrost nihala in $\omega'(t)$ pospešek kotne hitrosti.

## Funkcije

### Matematično nihalo
Funkcija `matematicno_nihalo(l, t, theta0, dtheta0, n)` izvaja numerično reševanje diferencialnih enačb za matematično nihalo. Parametri vključujejo dolžino nihala $l$, čas nihanja $t$, začetni kot $\theta_0$, začetno kotno hitrost $d\theta_0$ ter število korakov $n$. Uporablja metodo Runge-Kutta 4. reda za pridobivanje približnih rešitev. Ta metoda nam omogoča pridobivanje približnih rešitev diferencialnih enačb drugega reda z uporabo iterativnega postopka, ki temelji na ocenjevanju vpliva različnih odvodov na spremembo spremenljivk. S tem dosežemo bolj natančne približke rešitev.

Za začetek, funkcija definira dolžino enega koraka `h`, ki jo izračuna kot razmerje časa nihanja `t` in števila korakov `n`. Nato definira funkcijo sistema prvega reda `f(θ, ω)`, ki predstavlja odvoda kota `θ` in kotne hitrosti `ω`.

Med iteracijo znotraj zanke funkcija izvaja Runge-Kutta 4. reda, kjer za vsak korak izračuna vrednosti `k1`, `k2`, `k3` in `k4` na podlagi trenutnih vrednosti kota in hitrosti ter njunih kombinacij. Na koncu koraka se te vrednosti uporabijo za posodobitev kota `θ` in hitrosti `ω` z upoštevanjem uteženih povprečij teh vrednosti.

Rezultati se shranjujejo v tabelo `θ_vals`, ki vsebuje zaporedne vrednosti kota za vsak korak. Po končani iteraciji se ta tabela vrne kot izhod funkcije. 

### Harmonično nihalo
Funkcija `harmonicno_nihalo(l, t, theta0, n)` izračuna vrednosti za harmonično nihanje z analitično rešitvijo. Parametri so enaki kot pri funkciji za matematično nihalo.

### Maksimalni kot in nihajni čas
Funkcija `vrni_maksimalno_theta(l, theta0, dtheta0)` izračuna maksimalni kot $\theta_{\text{max}}$, do katerega nihalo doseže pri začetnem kotu $\theta_0$ in začetni hitrosti $\theta'(0) = \text{dtheta0}$. Uporablja relacijo za izračun tega kota: 
```math
\arccos\left(\cos(\theta_0) - \frac{l}{2g} \cdot d\theta_0^2\right)

```

Funkcija `izracunaj_nihalni_cas(l, theta0, dtheta0)` izračuna nihalni čas nihala pri istih začetnih pogojih. Uporablja analitično rešitev za nihalni čas, ki vključuje Eliptične integrale in maksimalno vrednost $\theta$:
```math
4 \cdot \sqrt{\frac{l}{g}} \cdot F\left(\frac{\pi}{2}, \sin^2\left(\frac{\theta_{\text{max}}}{2}\right)\right)

```

### Energija nihala
Funkcija `energija(m, l, theta0, dtheta0)` izračuna energijo nihala pri začetnem kotu $\theta_0$ in začetni hitrosti $\theta'(0) = \text{dtheta0}$. Uporablja formulo za energijo nihala, ki upošteva kinetično in potencialno energijo.
```math
m \cdot (g \cdot l \cdot (1 - \cos(\theta_0)) + 0.5 \cdot l^2 \cdot \dot{\theta}_0^2)

```

### Odvisnost nihalnega časa in energije od začetnih pogojev
Funkcija `vrni_nihajni_cas_in_energijo(m, l, n, theta_max, dtheta0)` izračuna nihalni čas ter energijo nihala v odvisnosti od začetnih pogojev. Parametri vključujejo maso nihala $m$, dolžino nihala $l$, število korakov $n$, maksimalni kot $\theta_{\text{max}}$ in začetno hitrost $\theta'(0) = \text{dtheta0}$. Vrne pare točk `(energija_vals, t_vals)` potrebne za izris grafa.

## Primerjava matematičenga in harmoničnega nihala
Primer uporabe funkcij je v funkciji `primerjaj_z_harmonicnim_nihalom(l, t, theta0, dtheta0, n)`, ki primerja numerično rešitev matematičnega nihala z analitično rešitvijo harmoničnega nihala in izrisuje graf. Pri harmoničnem nihalu nihajni čas ni odvisen od začetnih pogojev (energije), kar pomeni da je `dtheta0 = 0`. Zato funkcija sprejme enake parametre kot funkciji za numerično in harmonično nihanje.

## Izris grafa nihajnega časa in energije
Funkcija `izrisi_graf(m, l, n, theta_max=π/2)` izriše graf, ki prikazuje odvisnost nihalnega časa od energije nihala. V grafu primerjamo scenarije z različnimi začetnimi hitrostmi. Uporabljeni parametri vključujejo maso nihala $m$, dolžino nihala $l$, število korakov $n$ ter maksimalni kot $\theta_{\text{max}}$.

## Rezultati
Primerjali smo nihanje matematičnega in harmoničnega nihala tako, da smo napisali test in preverili, ali je razlika med tema dvema znotraj tolerance. Primerjavo smo predstavili tudi grafično, pri čemer opazujemo, da obe krivulji pri pogoju `dtheta0 = 0.0` zavzemata približno enak položaj. V primeru parametra `dtheta0 > 0.0` pa opazimo večje odstopanje.
![](https://github.com/bi4528/matematicno-nihalo/blob/master/MN/graphs/primerjava-dt0.png)
![](https://github.com/bi4528/matematicno-nihalo/blob/master/MN/graphs/primerjava-dt005.png)
![](https://github.com/bi4528/matematicno-nihalo/blob/master/MN/graphs/primerjava-dt01.png)

Nato smo izrisali graf, s katerim smo želeli prikazati odvisnost nihajnega časa od energije, s čimer smo hoteli pokazati, kako nihajni čas variira glede na začetne pogoje. Višja energija pomeni večjo amplitudo nihala in manjše število nihajev v istem časovnem intervalu. To se izkaže v daljšem nihajnem času, kot je razvidno iz grafa. S spreminjanjem parametra `dtheta0` smo tudi pokazali, kako se matematično nihalo ob spremenjenih začetnih pogojih giblje drugače. Na primer, ob začetni hitrosti `0.1 rad/s` krivulja manj strmoglavo narašča kot pri začetni hitrosti `0.4 rad/s`.
![](https://github.com/bi4528/matematicno-nihalo/blob/master/MN/graphs/nihajni-cas-energija.png)
