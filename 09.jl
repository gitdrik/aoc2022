open("09.txt") do f
    rope = fill((0,0), 10)
    p1, p2 = Set([(0,0)]), Set([(0,0)])
    dirs = Dict('U'=>(-1,0), 'R'=>(0,1), 'D'=>(1,0), 'L'=>(0,-1))
    for (dir, n) ∈ [(dirs[l[1]], parse(Int, l[3:end])) for l ∈ eachline(f)]
        for _ ∈ 1:n 
            rope[1] = rope[1] .+ dir
            for i ∈ 2:10
                delta = rope[i-1] .- rope[i] 
                if any(abs.(delta) .> 1)
                    rope[i] = rope[i] .+ sign.(delta)
                end
            end
            push!(p1, rope[2])
            push!(p2, rope[10])
        end
    end
    println("Part 1: ", length(p1))
    println("Part 2: ", length(p2))
end
