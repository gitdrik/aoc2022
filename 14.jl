open("14.txt") do f
    D = eachline(f) .|> l->split(l," -> ") .|> s->parse.(Int, split(s,','))
    R = Set{Tuple{Int,Int}}()
    for l ∈ D, i ∈ 1:length(l)-1
        c1, r1 = l[i]
        c2, r2 = l[i+1]
        for r ∈ min(r1,r2):max(r1,r2), c ∈ min(c1,c2):max(c1,c2)
            push!(R, (r, c))
        end
    end

    function sand!(R, p2)
        maxr = maximum(r for (r,_) ∈ R)
        units = 0
        done = false
        while !done
            c = 500
            for r ∈ 0:maxr+p2
                if r == maxr+p2
                    if !p2
                        done = true
                        break
                    end
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
                    done = r==0
                    break
                end
            end
        end
        return units
    end
    println("Part 1: ", sand!(deepcopy(R), false))
    println("Part 2: ", sand!(R, true))
end