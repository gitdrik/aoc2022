open("19.txt") do f
    # ore, clay, obsidian, geode
    B = []
    for l ∈ eachline(f)
        l = tryparse.(Int, split(l))
        push!(B, [
            [ l[7],     0,     0, 0],
            [l[13],     0,     0, 0],
            [l[19], l[22],     0, 0],
            [l[28],     0, l[31], 0]])
    end

    function geobound(r, s, t, b)
        # Make a maximum estimate based on ability
        # to manufacture 1 robot of each kind
        # and unlimited amounts of ore
        clay, clayr = s[2], r[2]
        obs, obsr = s[3], r[3]
        obsr = r[3]
        geo, geor = s[4], r[4]
        geor = r[4]
        clayuse = b[3][2]
        obsuse = b[4][3]
        for _ ∈ t:-1:1
            clay += clayr    
            obs += obsr
            geo += geor
            if obs-obsr ≥ obsuse
                obs -= obsuse
                geor += 1
            end
            if clay-clayr ≥ clayuse
                clay -= clayuse
                obsr +=1
            end
            clayr += 1
        end
        return geo
    end

    function make(b, robots, stuff, time)
        Q = Set([(robots, stuff, time)])
        #Global best solution
        maxgeode = 0
        #Maximum number of ore robots that make sense
        maxore   = max(b[2][1],b[3][1],b[4][1])
        while !isempty(Q)
            (r, s, t) = pop!(Q)
            if t==0
                maxgeode = max(maxgeode, s[4])
                continue
            end

            #Estimate if it could be possible to beat the previous best
            geobound(r,s,t,b) ≤ maxgeode && continue

            push!(Q, (r, s.+r, t-1))
            for i ∈ 1:4
                i==1 && r[1]==maxore && continue
                if all(s .≥ b[i])
                    rr = copy(r)
                    ss = copy(s)
                    ss .-= b[i]
                    ss .+= rr
                    rr[i] += 1
                    push!(Q, (rr, ss, t-1))
                end
            end
        end
        maxgeode
    end
    
    G = []
    stuff = [0, 0, 0, 0]
    robots = [1, 0, 0, 0]
    for b ∈ B
        g = make(b, robots, stuff, 24)
        push!(G, g)
    end
    println("Part 1: ", sum(G .* eachindex(G)))

    G = []
    for b ∈ B[1:3]
        g = make(b, robots, stuff, 32)
        push!(G, g)
    end
    println("Part 2: ", prod(G))
end