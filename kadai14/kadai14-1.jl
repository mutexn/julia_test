using Plots

function f_test(x_1, x_2)
    return exp(- x_1^2 - x_2^2)
end

function f_fit(x_1, x_2)
    phi = tanh.(v * [x_1, x_2] + b)
    return w0 + w' * phi
end

function linear_regress(x, y)
    Dimentions = size(x, 1)
    Data_Numbers = size(x, 2)
    A = hcat(ones(Data_Numbers), x')
    w = (A' * A) \ (A' * y')
    return w[1], w[2:Dimentions+1]
end

# 学習データの生成
dataNumbers = 100
x = rand(2, dataNumbers)
y = zeros(1, dataNumbers)
for n = 1:dataNumbers
    y[1, n] = f_test(x[1, n], x[2, n]) + 0.1randn()
end

# 初期値の定義
M = 5
v = randn(M, 2)
b = randn(M)
phi = zeros(M, dataNumbers)

# phiの計算
for n = 1:dataNumbers
    for j = 1:M
        phi[j, n] = tanh(x[1, n]*v[j, 1] + x[2, n]*v[j, 2] + b[j])
    end
end

# w0, wの学習
w0, w = linear_regress(phi, y)


x1_grid = 0:0.05:1.0
x2_grid = 0:0.05:1.0

y_plot = f_test.(x1_grid', x2_grid)
y_pre = f_fit.(x1_grid', x2_grid)

plt_1 = contour(x1_grid, x2_grid, y_plot, xlims=(0, 1), ylims=(0, 1), aspect_ratio=:equal, xlabel="x1", ylabel="x2")
plt_2 = contour(x1_grid, x2_grid, y_pre, xlims=(0, 1), ylims=(0, 1), aspect_ratio=:equal, xlabel="x1", ylabel="x2")

plot(plt_1, plt_2)