open("12.txt") do f
    M = Array{Char}(undef, 41, 113)
    for (i, l) ∈ enumerate(eachline(f))
        M[i,:] = collect(l)
    end
    @assert M[21,89]=='E'
    M[21,89] = 'z'
    goal = (21, 89)
    @assert M[21,1]=='S'
    M[21,1] = 'a'
    start = (21,1)

    function p1(start, goal)
        Q = [(0, start...)]
        seen = Set{Tuple{Int,Int}}()
        while !isempty(Q)
            steps, r, c = pop!(Q)
            (r,c) ∈ seen && continue
            push!(seen, (r, c))
            (r,c) == goal && return steps
            for (dr,dc) ∈ [(-1,0), (0,1), (1,0), (0,-1)]
                nr, nc = r+dr, c+dc
                (nr ∉ 1:41 || nc ∉ 1:113) && continue
                M[nr,nc] - M[r,c] > 1 && continue
                pushfirst!(Q, (steps+1,nr,nc))
            end
        end
    end
    println("Part 1: ", p1(start, goal))

    function p2(goal)
        Q = [(0, goal...)]
        seen = Set{Tuple{Int,Int}}()
        while !isempty(Q)
            steps, r, c = pop!(Q)
            (r,c) ∈ seen && continue
            push!(seen, (r, c))
            M[r,c] == 'a' && return steps
            for (dr,dc) ∈ [(-1,0), (0,1), (1,0), (0,-1)]
                nr, nc = r+dr, c+dc
                (nr ∉ 1:41 || nc ∉ 1:113) && continue
                M[nr,nc] - M[r,c] < -1 && continue
                pushfirst!(Q, (steps+1,nr,nc))
            end
        end
    end
    println("Part 2: ", p2(goal))
end