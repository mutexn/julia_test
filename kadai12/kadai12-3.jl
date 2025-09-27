using Plots
using MLDatasets
using DataFrames

# xの行数は次元数、列数がデータ数
# yは横ベクトル

function linear_regress(x, y)
    Dimentions = size(x, 1)
    Data_Numbers = size(x, 2)
    A = hcat(ones(Data_Numbers), x')
    w = (A' * A) \ (A' * y')
    return w[1], w[2:Dimentions+1]
end

function createPlot()
    features = BostonHousing.features()
    target = BostonHousing.targets()

    # x, yの定義
    x = copy(features)
    y = copy(target)

    # wの計算
    w0, w = linear_regress(x, y)
    
    # プロット
    y_pre = w'*x .+ w0
    plot(y', y_pre', st=scatter, xlim=(0, 50), ylim=(0, 55), xlabel="actual", ylabel="prediction"); plot!(x -> x)
end

createPlot()