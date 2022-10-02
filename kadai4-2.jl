using Plots

function logistic(a, x_ini, n_max)
    x = zeros(n_max)
    x[1] = x_ini
    for i = 1:n_max-1
        x[i+1] = a * x[i] *(1 - x[i])
    end
    return x
end

a = 3.9
x_ini = 0.1
n_max = 500
t = 1:1:n_max
plot(t, logistic(a, x_ini, n_max), xlabel = "n", ylabel = "x_n", title = "Logistic Map(a = 2)")
