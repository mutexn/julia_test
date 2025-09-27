function fib_1(n)
    if n == 1 
        return 1
    elseif n == 2
        return 1
    else
        a = 0
        b = 1
        c = a + b
        for i = 3:n
            a = b
            b = c
            c = a + b
        end
        return c
    end
end

function fib_2(n)
    if n == 1
        return 1
    elseif n == 2
        return 1
    else
        return fib_2(n-2) + fib_2(n-1)
    end
end

println(@time fib_1(20), @time fib_2(20))

# 速度に大きな差が出る理由は、計算の実行回数がfib_2のほうが大きいため。