open("06.txt") do f
    C = collect(readline(f))
    for i ∈ 4:length(C)
        if length(Set(C[i-3:i]))==4
            println("Part 1: ", i)
            break
        end
    end
    for i ∈ 14:length(C)
        if length(Set(C[i-13:i]))==14
            println("Part 2: ", i)
            break
        end
    end
end
