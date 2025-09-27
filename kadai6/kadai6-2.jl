using Plots

function f(a, x)
    return a * x * (1-x)
end

function sol(p, x, dt)
    return x * exp(p * dt) / (1 - x + x*exp(p*dt))
end 

function euler(p, x, dt)
    return x + dt * f(p, x)
end

function rk(p, x, dt)
    k_1 = f(p, x)*dt
    k_2 = f(p, x + k_1/2)*dt
    k_3 = f(p, x + k_2/2)*dt
    k_4 = f(p, x + k_3)*dt
    return x + (k_1 + 2*k_2 + 2*k_3 + k_4)/6 
end


function createPlot(p, x_0, dt, nt_max)
    t_grid = 0:dt:nt_max*dt
    x_euler = zeros(nt_max + 1)
    x_rk = zeros(nt_max + 1)
    x_exact = zeros(nt_max + 1)
    
    x_euler[1] = x_0
    x_rk[1] = x_0
    x_exact[1] = x_0

    for i = 1:nt_max
        x_euler[i+1] = euler(p, x_euler[i], dt)
        x_rk[i+1] = rk(p, x_rk[i], dt)
        x_exact[i+1] = sol(p, x_rk[i], dt)
    end

    plot(t_grid, x_euler, label = "Euler"); plot!(t_grid, x_rk, label = "Rk"); plot!(t_grid, x_exact, label = "Exact")
end


createPlot(1.0, 0.1, 0.2, 50)
savefig("kadai6-2.png")