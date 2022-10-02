for n = 1:100
    if n % 3 == 0 && n % 5 == 0
        println("FizzBuzz")
    elseif n % 3 == 0
        println("Fizz")
    elseif n % 5 == 0
        println("Buzz")
    else
        println(n)
    end
end