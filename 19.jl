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

    function geobound(r, s, b, t)
        # Make a maximum estimate based on geodes and obisdian
        # (unlimited clay and ore)
        obs = s[3]
        obsr = r[3]
        geo = s[4]
        geor = r[4]
        for tt ∈ t:-1:1          
            pass
        end
    end

    function make(b, robots, stuff, time)
        Q = Set([(robots, stuff, time)])
        #Global best solution
        maxgeode = 0
        #Maximum number of ore, clay and obsidian robots that make sense
        maxore   = max(b[2][1],b[3][1],b[4][1])
#        maxclay  = max(b[3][2],b[4][2])
#        maxobs   = max(b[4][3])
        while !isempty(Q)
            (r, s, t) = pop!(Q)
            if t==0
                if s[4] > maxgeode
                    maxgeode = s[4]
                    println(maxgeode, r)
                end
                continue
            end
            #Estimate if it is possible to beat the best previously found soutin
            tt = t-1
            s[4] + t*r[4] + (tt*tt+tt)÷2 ≤ maxgeode && continue
            #s[4] + (r[4]+2)*t ≤ maxgeode && continue

            push!(Q, (r, s.+r, t-1))

            for i ∈ 1:4
                i==1 && r[1]==maxore && continue
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