open("19.txt") do f
    # ore, clay, obsidian, geode
    B = []
    for l ∈ eachline(f)
        l = tryparse.(Int, split(l))
        push!(B, [[ l[7],     0,     0, 0],
                  [l[13],     0,     0, 0],
                  [l[19], l[22],     0, 0],
                  [l[28],     0, l[31], 0]])
    end

    function make(b, robots, stuff, time)
        Q = Set([(robots, stuff, time)])
        maxgeode = 0
        while !isempty(Q)
            (r, s, t) = pop!(Q)
#            s[4]+r[4]*t+(t*t+t)÷2 ≤ maxgeode && continue
            s[4] + (r[4]+2)*t ≤ maxgeode && continue
            if t==0
                if s[4] > maxgeode
                    maxgeode = s[4]
                    println(maxgeode, r)
                end
                continue
            end
            push!(Q, (r, s.+r, t-1))

            for i ∈ 1:4
                if all(s .≥ b[i])
                    rr = copy(r)
                    ss = copy(s)
                    rr[i] += 1
                    ss[i] -= 1
                    ss .-= b[i]
                    ss .+= rr
                    push!(Q, (rr, ss, t-1))
                end
            end
        end
        maxgeode
    end
    
    G = []
    for b ∈ B
        stuff = [0, 0, 0, 0]
        robots = [1, 0, 0, 0]
        println(b)
        g = make(b, robots, stuff, 24)
        push!(G, g)
        println(G)
    end
    println(sum(G .* eachindex(G)))
end