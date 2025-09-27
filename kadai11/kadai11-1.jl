using Plots

function update_Langevin(x, v, p)
   ganma, kappa, dt = p 
   x_new = x + dt * v
   v_new = v - dt*ganma*v + sqrt(kappa*dt) * randn()
   return x_new, v_new
end

function create_Plot()
    # 初期値の定義
    nt_max = 1000
    ganma = 1.0
    kappa = 1.0
    dt = 0.01
    p = [ganma, kappa, dt]
    dataset_counts = 3

    # データの用意
    t_grid = 0:dt:nt_max*dt
    x_data = zeros(dataset_counts, length(t_grid))
    v_data = zeros(dataset_counts, length(t_grid))

    # v, xの計算
    for i = 1:dataset_counts
        for j = 1:nt_max
            x_data[i, j+1], v_data[i, j+1] = update_Langevin(x_data[i, j], v_data[i, j], p)
        end    
    end
    
    #プロット
    plot(t_grid, x_data[1, :], xlabel="t", ylabel="x", title="Position"); plot!(t_grid, x_data[2, :]); plot!(t_grid, x_data[3, :])
    plot(t_grid, v_data[1, :], xlabel="t", ylabel="v", title="Velocity"); plot!(t_grid, v_data[2, :]); plot!(t_grid, v_data[3, :])
end

create_Plot()