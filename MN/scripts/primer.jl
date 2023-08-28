using DifferentialEquations
using Plots

# Define the system of first-order ODEs
function pendulum_eq(du, u, p, t)
    g, l = p
    du[1] = u[2]
    du[2] = -(g/l) * sin(u[1])
end

# Initial conditions and parameters
θ_0 = π / 4
ω_0 = 0.0
g = 9.81  # acceleration due to gravity (m/s²)
l = 1.0   # length of the pendulum (m)

u0 = [θ_0, ω_0]
tspan = (0.0, 10.0)  # Time span for the simulation

# Define the problem
prob = ODEProblem(pendulum_eq, u0, tspan, (g, l))

# Solve the ODE
sol = solve(prob, Tsit5())

# Access solution
t = sol.t
θ = sol.u[1, :]

# Plot the solution
plot(t, θ, label="θ(t)", xlabel="Time", ylabel="Angle θ")
