open("24.txt") do f
    N = BitMatrix(undef, 25, 120)
    E = BitMatrix(undef, 25, 120)
    S = BitMatrix(undef, 25, 120)
    W = BitMatrix(undef, 25, 120)
    readline(f)
    for r ∈ 1:25
        l = collect(readline(f))[2:121]
        N[r,:] = l .== '^'
        E[r,:] = l .== '>'
        S[r,:] = l .== 'v'
        W[r,:] = l .== '<'
    end
    moves = [(0,0), (0,1), (1,0), (0,-1), (-1,0)]

    function walk(start, goal, t)
        r, c = start
        Q = [(t, r, c)]
        seen = Set{Tuple{Int, Int, Int}}()
        while !isempty(Q)
            t, r, c = popfirst!(Q)
            (r, c) == goal && return t
            (t, r, c) ∈ seen && continue
            push!(seen, (t, r, c))
            if (r, c) != start && (r ∉ 1:25 || c ∉ 1:120 ||
                N[mod1(r+t, 25), c] || E[r, mod1(c-t, 120)] ||
                S[mod1(r-t, 25), c] || W[r, mod1(c+t, 120)])
                continue
            end
            for (dr, dc) ∈ moves
                push!(Q, ((t+1), r+dr, c+dc))
            end
        end
    end
    start, goal = (0,1), (26,120)
    t = walk(start, goal, 0)
    println("Part 1: ", t)
    t = walk(goal, start, t)
    t = walk(start, goal, t)
    println("Part 2: ", t)
end