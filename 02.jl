open("02.txt") do f
    S = [(l[1]-'A', l[3]-'X') for l ∈ eachline(f)]
    println("Part 1: ", sum([1+b+3*mod(1-a+b, 3) for (a,b) ∈ S]))
    println("Part 2: ", sum([1+mod(2+a+b, 3)+3*b for (a,b) ∈ S]))
end