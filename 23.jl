function run()
open("23.txt") do f
    E = Set{Tuple{Int,Int}}()
    for (r, l) ∈ enumerate(eachline(f)), (c, e) ∈ enumerate(l)
        e=='#' && push!(E, (r,c))
    end

    D = [[(-1,-1),(-1, 0),(-1, 1)],
         [( 1,-1),( 1, 0),( 1, 1)],
         [(-1,-1),( 0,-1),( 1,-1)],
         [(-1, 1),( 0 ,1),( 1, 1)]]

    N = [(a, b) for a ∈ -1:1 for b ∈ -1:1 if (a, b)!=(0,0)]

    for t = Iterators.countfrom(1)
        movement = false
        P, B = Set{Tuple{Int,Int}}(), Set{Tuple{Int,Int}}()
        for e∈E
            !any(p ∈ E for p ∈ [n.+e for n∈N]) && continue
            for d ∈ D
                if !any(p ∈ E for p ∈ [e.+n for n∈d])
                    if e.+d[2] ∈ P
                        push!(B, e.+d[2])
                    else
                        push!(P, e.+d[2])
                    end
                    break
                end
            end
        end
        nE = Set{Tuple{Int,Int}}()
        for e∈E
            if !any(p ∈ E for p ∈ [n.+e for n∈N])
                push!(nE, e)
            else
                done = false
                for d∈D
                    if !any(p ∈ E for p ∈ [n.+e for n∈d])
                        done = true
                        if e.+d[2] ∈ B
                            push!(nE, e)
                        else
                            push!(nE, e.+d[2])
                            movement = true
                        end
                        break
                    end
                end
                !done && push!(nE, e)
            end
        end
        E = nE
        circshift!(D, -1)
        if t==10
            minr, maxr = extrema([r for (r, _) ∈ E])
            minc, maxc = extrema([c for (_, c) ∈ E])
            println("Part 1: ", (maxr-minr+1)*(maxc-minc+1)-length(E))
        end
        if !movement
            println("Part 2: ", t)
            break
        end
    end
end
end