using Plots

# xの行数は次元数、列数がデータ数
# yは横ベクトル
# D次元、Kクラス、N個のデータ数

function linear_regress(x, y)
    M = size(x, 1)
    N = size(x, 2)
    K = size(y, 1)

    A = hcat(ones(N), x')
    w = (A' * A) \ (A' * y')
    return w[1, :], w[2:M+1, :]
end

function f_class_1(x_1, x_2)
    return w0[1] + w[1, 1] * x_1 + w[2, 1] * x_2
end

# データセットの用意
N = 500
x_1 = randn(2, div(N, 2)) .+ 2.0
x_2 = randn(2, div(N, 2)) .- 2.0
x = hcat(x_1, x_2)

y_1 = repeat([1, 0], 1, div(N, 2))
y_2 = repeat([0, 1], 1, div(N, 2))
y = hcat(y_1, y_2)

# 回帰係数の計算
w0, w = linear_regress(x, y)

# プロット
x1_grid = -5.0:0.1:5.0
x2_grid = -5.0:0.1:5.0

plot(x_1[1, :], x_1[2, :], st=scatter, label="class 1", xlabel="x1", ylabel="x2", xlims=(-5.0, 5.0), ylims=(-5.0, 5.0), camera=(30, 30))
plot!(x_2[1, :], x_2[2, :], st=scatter, label="class 2")
contour!(x1_grid, x2_grid, f_class_1.(x1_grid', x2_grid))