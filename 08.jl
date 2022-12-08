open("08.txt") do f
    F = fill(-1, 101, 101)
    for (i, l) ∈ enumerate(eachline(f))
        F[i+1, 2:100] = [parse.(Int, c) for c ∈ l]
    end

    function isvisible(h, r, c, dr, dc)
        F[r+dr, c+dc] == -1 && return true
        F[r+dr, c+dc] ≥ h && return false
        return isvisible(h, r+dr, c+dc, dr, dc)
    end
    p1 = 0
    for r∈2:100, c∈2:100
        for (dr, dc) ∈ [(0,1),(1,0),(0,-1),(-1,0)]
            if isvisible(F[r,c], r, c, dr, dc)
                p1 +=1
                break
            end
        end
    end
    println("Part 1: ", p1)

    function trees(h, r, c, dr, dc)
        F[r+dr, c+dc] == -1 && return 0
        F[r+dr, c+dc] ≥ h && return 1
        return 1 + trees(h, r+dr, c+dc, dr, dc)
    end
    p2 = 0
    for r∈2:100, c∈2:100
        score = prod([trees(F[r,c],r,c,dr,dc) for (dr,dc)∈[(0,1),(1,0),(0,-1),(-1,0)]])
        p2 = max(score, p2)
    end
    println("Part 2: ", p2)
end