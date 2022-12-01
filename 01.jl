open("01.txt") do f
    C = [0]
    for l ∈ eachline(f)
        l == "" ? push!(C, 0) : C[end] += parse(Int, l)
    end
    println("Part 1: ", maximum(C))
    println("Part 2: ", sum(sort(C)[end-2:end]))
end
