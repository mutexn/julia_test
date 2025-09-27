using Plots

function logistic(a, x_ini, n_max)
    x = zeros(n_max)
    x[1] = x_ini
    for i = 1:n_max-1
        x[i+1] = a * x[i] *(1 - x[i])
    end
    return x
end

t = 1:1:50
plot(t, logistic(4.0, 0.1, 50), xlabel = "n", ylabel = "x", title = "Logistic Map(a = 4.0)")
savefig("kadai4-1_4.0.png")