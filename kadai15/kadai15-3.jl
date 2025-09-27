using Plots
using MLDatasets
using Flux
using Flux: onehotbatch, onecold
using LinearAlgebra

# xの行数は次元数、列数がデータ数
# yは横ベクトル
# D次元、Kクラス、N個のデータ数
function linear_regress(x, y)
    A = hcat(ones(size(x, 2)), x')  # データ数
    w = (A' * A) \ (A' * y)  
    return w[1, :], w[2:size(x, 1)+1, :]  # 次元
end

function calculate_phi(x, N)
    phi = zeros(M, N)
    for n = 1:N
        for j = 1:M
            input = b[j]
            for i = 1:D
                input += x[i, n] * v[j, i]
            end
            phi[j, n] = tanh(input)
        end
    end
    return phi
end

function calculate_conf_mat(digit_test, digit_pre)
    conf_mat = zeros(10, 10)
    for i = 1:length(digit_test)
        conf_mat[digit_test[i]+1, digit_pre[i]+1] += 1
    end
    return conf_mat / sum(conf_mat)
end

# データセットの用意
const image_train, digit_train = MLDatasets.MNIST(split=:train)[:]
const image_test, digit_test = MLDatasets.MNIST(split=:test)[:]

const x_train = Flux.flatten(image_train)
const x_test = Flux.flatten(image_test)
const y_train = onehotbatch(digit_train, 0:9)

# 初期値の設定
const M = 50
const D = size(x_train, 1)
const N_train = size(x_train, 2)
const N_test = size(x_test, 2)

const v = 0.1 * randn(M, D)
const b = randn(M)

# 回帰係数の計算
const w0, w = linear_regress(calculate_phi(x_train, N_train), y_train')

const y_pre = w' * calculate_phi(x_test, N_test) + repeat(w0, 1, 10000)
const digit_pre = onecold(y_pre, 0:9)

heatmap(0:9, 0:9, calculate_conf_mat(digit_test, digit_pre), xlabel="prediction", ylabel="actual")