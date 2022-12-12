open("12.txt") do f
    M = Array{Char}(undef, 41, 113)
    for (i, l) ∈ enumerate(eachline(f))
        M[i,:] = collect(l)
    end
    start = (21, 1)
    @assert M[start...]=='S'
    M[start...] = 'a'
    goal = (21, 89)
    @assert M[goal...]=='E'
    M[goal...] = 'z'

    function solve(start, goal)
        Q = [(0, start...)]
        seen = Set{Tuple{Int,Int}}()
        for (steps, r, c) ∈ Q
            (r,c) ∈ seen && continue
            push!(seen, (r, c))
            (r,c) == goal && return steps
            M[r,c] == goal && return steps
            for (dr, dc) ∈ [(-1,0), (0,1), (1,0), (0,-1)]
                nr, nc = r+dr, c+dc
                (nr ∉ 1:41 || nc ∉ 1:113) && continue
                M[r,c] - M[nr,nc] > 1 && continue
                push!(Q, (steps+1, nr, nc))
            end
        end
    end
    println("Part 1: ", solve(goal, start))
    println("Part 2: ", solve(goal, 'a'))
end