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

function createPlot(Data_Numbers)
    x = rand(Data_Numbers)
    y = 2*x .+ 1 + 0.5*randn(Data_Numbers)
    w0, w = linear_regress(x', y')
    plot(x, y, st=scatter, xlabel="x", ylabel="y", label="data"); plot!(x -> 2x+1, label="actual"); plot!(x -> w[1]*x + w0, label="fitting")
end

Data_Numbers = 100
createPlot(Data_Numbers)