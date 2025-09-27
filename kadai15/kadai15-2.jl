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
    phi = tanh.(v * [x_1, x_2] + b)
    return w0[1] + w[:, 1]' * phi
end

# 初期値の設定
N = 500
M = 10
K = 2

# データセットの用意
x_1 = randn(2, div(N, 2))
x_2 = zeros(2, div(N, 2))
for i = 1:div(N, 2)
    theta = 2pi * rand()
    x_2[:, i] = [5cos(theta), 5sin(theta)] + randn(2)
end
x = hcat(x_1, x_2)

y_1 = repeat([1, 0], 1, div(N, 2))
y_2 = repeat([0, 1], 1, div(N, 2))
y = hcat(y_1, y_2)

# phi
v = randn(M, 2)
b = randn(M)
phi = zeros(M, N)

for n = 1:N
    for j = 1:M
        phi[j, n] = tanh(x[1, n]*v[j, 1] + x[2, n]*v[j, 2] + b[j])
    end
end

# 回帰係数の計算
w0, w = linear_regress(phi, y)

# プロット
x1_grid = -7.0:0.1:7.0
x2_grid = -7.0:0.1:7.0

plot(x_1[1, :], x_1[2, :], st=scatter, label="class 1", xlabel="x1", ylabel="x2", xlims=(-7, 7), ylims=(-7, 7))
plot!(x_2[1, :], x_2[2, :], st=scatter, label="class 2")
contour!(x1_grid, x2_grid, f_class_1.(x1_grid', x2_grid))