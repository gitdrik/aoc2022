open("15.txt") do f
    N = [parse.(Int, split(l, r"=|,|:")[2:2:8]) for l ∈ eachline(f)]
    Y = 2000000

    function consolidate(R)
        nR = []
        sort!(R)
        a, b = R[1]
        for (an, bn) ∈ R[2:end]
            if an > b+1
                push!(nR, (a, b))
                a, b = an, bn
            elseif bn > b
                b = bn
            end
        end
        push!(nR, (a, b))
        return nR
    end

    len(R) = sum([b-a+1 for (a, b) ∈ R])

    R, B =  [], Set()
    for (sx, sy, bx, by) ∈ N
        reach = max(-1, (abs(sx-bx)+abs(sy-by)-abs(Y-sy)))
        push!(R, (sx-reach, sx+reach))
        by == Y && push!(B, bx)
    end
    println("Part 1: ", len(consolidate(R))-length(B))

    cmax = 4000000
    for y ∈ 0:cmax
        R = Array{Tuple{Int,Int}}([])
        for (sx, sy, bx, by) ∈ N
            reach = max(-1, (abs(sx-bx)+abs(sy-by)-abs(y-sy)))
            a, b = sx-reach, sx+reach
            (b < 0 || a > cmax) && continue
            push!(R, (max(0, a), min(cmax, b)))
        end
        R = consolidate(R)
        if length(R) > 1
            println("Part 2: ", cmax*(1+R[1][2])+y)
            break
        end
    end
end