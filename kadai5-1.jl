using Plots

function iter_number(c, z, n_max)
    i = 1
    while abs(z) < max(2, abs(c)) && i < n_max
        z = z^2 + c
        i += 1
    end
    return i
end


function create_julia_set(c, n_max, n_mesh)
    x = range(-2, 2; length = n_mesh)
    y = range(-2, 2; length = n_mesh)
    z = Complex.(x', y)
    n_iter = iter_number.(c, z, n_max)
    heatmap(x, y, log10.(n_iter))
end


create_julia_set(Complex(0, 2), 1000, 400)