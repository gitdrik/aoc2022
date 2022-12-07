using DataStructures

open("07.txt") do f
    path = []
    dirsize = DefaultDict(0)
    for l ∈ eachline(f)
        if startswith(l, "\$ cd ..")
            pop!(path)
        elseif startswith(l, "\$ cd")
            push!(path, split(l)[3])
        else
            if l[1] ∈ '0':'9'
                size = parse(Int, split(l)[1])
                for i ∈ eachindex(path)
                    dirsize[path[1:i]] += size
                end
            end
        end
    end
    println("Part 1: ", sum([s for (_,s) ∈ dirsize if s ≤ 100000]))

    S = dirsize[["/"]]
    for s ∈ sort([s for (_,s) ∈ dirsize])
        if 70000000-S+s ≥ 30000000
            println("Part 2: ", s)
            break
        end
    end 
end