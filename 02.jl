open("02.txt") do f
    S = [(l[1]-'A', l[3]-'X') for l ∈ eachline(f)]
    score = 0
    for (a, b) ∈ S
        score += 1 + b + 3*mod(1-a+b, 3)
    end
    println("Part 1: ", score)

    score  = 0
    for (a, b) ∈ S
        score += 1 + mod(2+a+b, 3) + 3*b
    end
    println("Part 2: ", score)
end