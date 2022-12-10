open("10.txt") do f
    p1, i, X = 0, 0, 1
    println("Part 2: ")
    for l ∈ eachline(f)
        print(i%40∈X-1:X+1 ? "█" : " ")
        i%40==39 && println()
        i += 1
        (i-20) % 40 == 0 && (p1 += i*X)
        if startswith(l, "addx")
            print(i%40∈X-1:X+1 ? "█" : " ")
            i%40==39 && println()
            i += 1
            (i-20) % 40 == 0 && (p1 += i*X)
            X += parse(Int, split(l)[2])
        end
    end
    println("Part 1: ", p1)
end