using Plots

# xの行数は次元数、列数がデータ数
# yは横ベクトル

function linear_regress(x, y)
    Dimentions = size(x, 1)
    Data_Numbers = size(x, 2)
    A = hcat(ones(Data_Numbers), x')
    w = (A' * A) \ (A' * y')
    return w[1], w[2:Dimentions+1]
end

function fit(x, w0, w)
    M = length(w)
    f = w0
    for i = 1:M
        f += w[i] * x^i
    end
    return f
end

function error(fit, w0, w, x, y)
    N = length(x)
    s = 0.0
    for n = 1:N
        s += (y[n] - fit(x[n], w0, w)^2)
    end
    return sqrt(s / N)
end

function createPlot(Data_Numbers, M)
    # x, yの定義
    x_train = 2pi * rand(Data_Numbers)
    y_train = sin.(x_train) + 0.1rand(Data_Numbers)
    x_test = 2pi * rand(Data_Numbers)
    y_test = sin.(x_test) + 0.1rand(Data_Numbers)

    # phiの計算
    Data_Numbers = size(x', 2)
    phi = x
    for i = 1:M-1
        phi = hcat(phi, phi[:, 1] .^ (i+1))
    end
    
    # wの計算
    w0, w = linear_regress(phi', y')

    # プロット
    plot(x -> fit(x, w0, w), label="fitting", xlim=(0, 6), ylim=(-1.0, 1.0)); plot!(x -> sin(x), label="sin x"); plot!(x, y, label="data", st=scatter)
end

Data_Numbers = 20
M = 5
createPlot(Data_Numbers, M)