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
        return fib(n-2) + fib(n-1)
    end
end

println(@time fib_1(100))
println(@time fib_2(100))