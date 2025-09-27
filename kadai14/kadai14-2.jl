using Plots
using Statistics

function f(p, u)
    f_1 = p[1] * (u[2] - u[1])
    f_2 = u[1] * (p[2] - u[3]) - u[2]
    f_3 = u[1] * u[2] - p[3] * u[3]
    return [f_1, f_2, f_3]
end

function rk(p, u, dt)
    k_1 = f(p, u) .* dt
    k_2 = f(p, u .+ k_1 ./ 2) .* dt
    k_3 = f(p, u .+ k_2 ./ 2) .* dt
    k_4 = f(p, u .+ k_3) .* dt
    return u .+ (k_1 .+ k_2 .* 2 .+ k_3 .* 2 .+ k_4) ./ 6 
end

function createTrainingData(p, u_0, dt, nt_max)
    t_grid = 0:dt:nt_max*dt
    u_data = zeros(3, nt_max + 1)
    u_data[1,1] = u_0[1]
    u_data[2,1] = u_0[2]
    u_data[3,1] = u_0[3]
    
    for i = 1:nt_max
        u_data[:, i+1] = rk(p, u_data[:, i], dt)
    end

    x_data = zeros(1, Int(nt_max // 2))
    z_data = zeros(1, Int(nt_max // 2))

    for i = 10002:nt_max+1
        x_data[i-10001] = u_data[1, i]
        z_data[i-10001] = u_data[3, i]
    end

    x_normal = (x_data .- mean(x_data)) / std(x_data)
    z_normal = (z_data .- mean(z_data)) / std(z_data)
    
    return x_normal, z_normal
end

function linear_regress(x, y)
    Dimentions = size(x, 1)
    Data_Numbers = size(x, 2)
    A = hcat(ones(Data_Numbers), x')
    w = (A' * A) \ (A' * y')
    return w[1], w[2:Dimentions+1]
end

# データの用意
sigma = 10; beta = 8/3; rho = 28
x_0 = 1.0; y_0 = 0.0; z_0 = 0.0
p = [sigma, rho, beta]
u_0 = [x_0, y_0, z_0]
dt = 0.01; nt_max = 20000
x_normal, z_normal = createTrainingData(p, u_0, dt, nt_max)

D = 5
N = div(length(x_normal), D)
feature = reshape(x_normal, D, N)
target = z_normal[D:D:end]

feature_train = feature[:,1:div(N, 2)]
feature_test = feature[:,div(N, 2)+1:N]

target_train = target[1:div(N, 2)]'
target_test = target[div(N, 2)+1:N]'

# 学習
M = 30
v = randn(M, D)
b = randn(M)

# phiの計算
phi_train = zeros(M, div(N, 2))

for n = 1:div(N, 2)
    for j = 1:M
        phi_train[j, n] = tanh(feature_train[1, n]*v[j, 1] + feature_train[2, n]*v[j, 2] + feature_train[3, n]*v[j, 3] + feature_train[4, n]*v[j, 4] + feature_train[5, n]*v[j, 5] + b[j])
    end
end

w0, w = linear_regress(phi_train, target_train)

z_fit = w' * phi_train .+ w0


# テストデータの加工
phi_test = zeros(M, div(N, 2))

for n = 1:div(N, 2)
    for j = 1:M
        phi_test[j, n] = tanh(feature_test[1, n]*v[j, 1] + feature_test[2, n]*v[j, 2] + feature_test[3, n]*v[j, 3] + feature_test[4, n]*v[j, 4] + feature_test[5, n]*v[j, 5] + b[j])
    end
end

w0, w = linear_regress(phi_test, target_test)

z_pre = w' * phi_test .+ w0

# Plot
t_grid = D*dt:D*dt:length(x_normal)*dt
t_grid_train = D*dt:D*dt:length(x_normal)*dt/2
t_grid_test = length(x_normal)*dt/2+D*dt:D*dt:length(x_normal)*dt

plot(t_grid, target, label="data", xlabel="t", ylabel="z", xlims=(40,60))
plot!(t_grid_train, z_fit', label="fitting")
plot!(t_grid_test, z_pre', label="prediction")