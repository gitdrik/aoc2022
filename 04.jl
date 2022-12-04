open("04.txt") do f
    W = [parse.(Int, split(l, r",|-")) for l ∈ eachline(f)]
    p1, p2 = 0, 0
    for (a, b, c, d) ∈ W
        p1 += a:b ⊆ c:d || c:d ⊆ a:b
        p2 += !isdisjoint(a:b, c:d)
    end
    println("Part 1: ", p1)
    println("Part 2: ", p2)
end