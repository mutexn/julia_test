using Plots
using Random

function hist(data, x_min, x_max, N_bin)
    dx = (x_max - x_min) / N_bin
    h = zeros(N_bin)
    for x in data
        n = Int(floor((x - x_min) / dx)) + 1
        if 1 <= n && n <= N_bin
            h[n] += 1
        end
    end
    return h / (sum(h) * dx)
end

function createPlot(N_bin)
    
    # histgram of rand()
    data_rand = rand(10^4)
    x_min_rand = 0.0
    x_max_rand = 1.0
    x_grid_rand = range(x_min_rand, x_max_rand,length = N_bin )
    h_rand = hist(data_rand, x_min_rand, x_max_rand, N_bin)

    # histgram of randn()
    data_randn = randn(10^4)
    x_min_randn = -4.0
    x_max_randn = 4.0
    x_grid_randn = range(x_min_randn, x_max_randn,length = N_bin )
    h_randn = hist(data_randn, x_min_randn, x_max_randn, N_bin)
    
    # create plots
    plot(x_grid_randn, h_randn, st=bar, title="NPD", label="histgram")
    plot(x_grid_rand, h_rand, st=bar, title="URN", label="histgram")
end


N_bin = 70
createPlot(N_bin)