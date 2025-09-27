using Plots
using LinearAlgebra

function createPlot()
    # 初期値の定義
    L = 10.0
    N = 100
    dx = L / N

    # データの用意
    x_grid = 0:dx:L
    H = zeros(N+1, N+1)

    # ハミルトニアンの計算
    for i = 1:N+1
        for j = 1:N+1
            if abs(i - j) == 1
                H[i, j] = -1 / 2 / dx^2
            elseif i == j
                H[i, j] = 1 / dx^2
            end
        end
    end
    
    # 固有値、固有関数の計算
    E_numerical, v = eigen(H)

    # 解析的な固有値の計算
    E_exact = zeros(N+1)
    for n = 1:N+1
        E_exact[n] = n^2 * pi^2 / 2 / L^2
    end

    plot(x_grid, v[:, 1:3]/sqrt(dx), title="Eigen Functions", xlabel="x")
    plot(E_numerical, xlabel="n", ylabel="E", title="Eigen Values", label="numerical"); plot!(E_exact, label="exact")
end

createPlot()