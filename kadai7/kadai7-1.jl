using Plots

function f(p, u)
    f_1 = p[1] * (u[2] - u[1])
    f_2 = u[1] * (p[2] - u[3]) - u[2]
    f_3 = u[1] * u[2] - p[3] * u[3]
    return [f_1, f_2, f_3]
end

function rk(p, u, dt)
    k_1 = f(p, u) .* dt
    k_2 = f(p, u .+ k_1 ./ 2) .* dt
    k_3 = f(p, u .+ k_2 ./ 2) .* dt
    k_4 = f(p, u .+ k_3) .* dt
    return u .+ (k_1 .+ k_2 .* 2 .+ k_3 .* 2 .+ k_4) ./ 6 
end

function createPlot(p, u_0, dt, nt_max)
    t_grid = 0:dt:nt_max*dt
    u_data = zeros(3, nt_max + 1)
    u_data[1,1] = u_0[1]
    u_data[2,1] = u_0[2]
    u_data[3,1] = u_0[3]
    
    for i = 1:nt_max
        u_data[:, i+1] = rk(p, u_data[:, i], dt)
    end

    plot(u_data[1, :], u_data[2,:], u_data[3, :], xlabel="x", ylabel="y", zlabel="z")
    plot(t_grid, u_data[1,:], xlabel="x", ylabel="y", zlabel="z")
end

createPlot([10, 28, 8/3], [1.0, 0.0, 0.0], 0.01, 20000)