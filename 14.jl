open("14.txt") do f
    L = eachline(f) .|> l->split(l," -> ") .|> s->parse.(Int, split(s,','))
    R = Set{Tuple{Int,Int}}()
    for l ∈ L, ((c1, r1), (c2, r2)) ∈ zip(l, l[2:end])
        for r ∈ min(r1,r2):max(r1,r2), c ∈ min(c1,c2):max(c1,c2)
            push!(R, (r, c))
        end
    end

    function sand!(R, p2)
        maxr = maximum(r for (r,_) ∈ R)
        units = 0
        while true
            c = 500
            for r ∈ 0:maxr+p2
                if r == maxr+p2
                    !p2 && return units
                    push!(R, (r, c))
                    units += 1
                elseif (r+1, c) ∉ R
                    continue
                elseif (r+1, c-1) ∉ R
                    c -= 1
                    continue
                elseif (r+1, c+1) ∉ R
                    c += 1
                    continue
                else
                    push!(R, (r, c))
                    units += 1
                    r==0 && return units
                    break
                end
            end
        end
    end
    println("Part 1: ", sand!(deepcopy(R), false))
    println("Part 2: ", sand!(R, true))
end