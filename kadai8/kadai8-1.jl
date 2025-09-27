using Plots

function f(p, u)
    D, dx = p
    N = length(u)
    du = zeros(N)

    for i = 2:N-1
        du[i] = D * (u[i+1] - 2*u[i] + u[i-1]) / dx^2
    end

    #周期的境界条件
    du[N] = D * (u[1] - 2*u[N] + u[N-1]) / dx^2

    return du
end

function rk(p, u, dt)
    k_1 = f(p, u) .* dt
    k_2 = f(p, u .+ k_1 ./ 2) .* dt
    k_3 = f(p, u .+ k_2 ./ 2) .* dt
    k_4 = f(p, u .+ k_3) .* dt
    return u .+ (k_1 .+ k_2 .* 2 .+ k_3 .* 2 .+ k_4) ./ 6 
end

function createPlot(D, dt, nt_max)  
    # 初期値の定義
    N = 40
    L = 10.0
    dx = L / N
    p = [D, dx]
    
    # データの用意
    x_grid = dx:dx:L
    t_grid = 0:dt:nt_max*dt
    u_data = zeros(N, nt_max + 1)

    #初期条件
    Gauss(x, mu, sigma) = exp(-(x-mu)^2 / (2*sigma^2)) / sqrt(2*pi*sigma^2)
    u_data[:, 1] = Gauss.(x_grid, L/2, 1.0)

    test = u_data[:, 1]

    #計算
    for i = 1:nt_max
        u_data[:, i+1] = rk(p, u_data[:, i], dt)
    end

    #プロット
    plot(x_grid, u_data, label="", xlabel="x", ylabel="u")
    heatmap(t_grid, x_grid, u_data, xlabel="t", ylabel="x")
end

D = 1.0
dt = 0.025
nt_max = 100
createPlot(D, dt, nt_max)