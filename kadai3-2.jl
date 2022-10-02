function trace(A)
    N = size(A, 1)
    i = 0
    if size(A, 1) == size(A, 2)
        for n = 1:N
            i = i + A[n, n]
        end
        return i
    else
        println("error: not square matrix")
    end
end