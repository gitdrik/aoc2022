using DataStructures

open("16.txt") do f
    G = Dict{String, Set{String}}()
    V = Dict{String, Int}()
    for l ∈ eachline(f)
        ss = split(l, r", |; |=| ")
        n, rate, childs = ss[2], parse(Int, ss[6]), ss[11:end]
        (n=="AA" || rate != 0) && (V[n] = rate)
        G[n] = Set(childs)
    end

    #Shortest paths between all nonzero nodes (and AA)
    G2 = DefaultDict{String, Dict{String, Int}}(Dict())
    minDist = typemax(Int) # used for opitimization
    for n ∈ keys(V)
        d = 0
        Q = [(n, d)]
        seen = Set()
        while !isempty(Q)
            p, d = popfirst!(Q)
            p ∈ seen && continue
            push!(seen, p)
            if p ∈ keys(V) && p != n
                G2[n][p] = d
                G2[p][n] = d
                minDist = min(minDist, d)
            end
            for pp ∈ G[p]
                push!(Q, (pp, d+1))
            end
        end
    end

    # Find max vol
    maxv = 0
    N = [n for n ∈ keys(V) if n != "AA"]
    t, flow, vol = 31, 0, 0
    Q = [(t, flow, vol, "AA", N)]
    while !isempty(Q)
        t, flow, vol, n, N = pop!(Q)
        if (t ≤ 0)
            maxv = max(maxv, vol)
            continue
        end
        nflow = flow + V[n]
        minv = vol+flow+(t-1)*nflow
        if isempty(N)
            maxv = max(maxv, minv)
            continue
        end

        # Make upper bound estimate
        flows = sort([V[n] for n∈N], rev=true)
        rvol, rtime = 0, t-1
        for flow ∈ flows
            rtime < 1 && break
            rvol += flow*rtime
            rtime -= 1+minDist
        end
        # Stop if no chance of beating best
        minv + rvol ≤ maxv && continue 

        for nn ∈ N
            nt = t - 1 - G2[n][nn]
            nvol = vol + flow + nflow*min(t-1, G2[n][nn])
            NN = filter(!=(nn), N)
            push!(Q, (nt, nflow, nvol, nn, NN))
        end
    end
    println("Part 1: ", maxv)

    # Find max vol
    maxv = 0
    t, flow, vol = 26, 0, 0
    N = [n for n ∈ keys(V) if n != "AA"]
    Q = [(t, flow, 0, vol, "AA", "AA", 0, 0, N)]
    while !isempty(Q)
        t, flow, nflow, vol, n1, n2, w1, w2, N = pop!(Q)
        flow = flow + nflow
        minv = vol+flow*t
        if t==0 || isempty(N)
            maxv = max(maxv, minv)
            continue
        end

        # Make upper bound estimate
        rvol, rtime = 0, t-1
        flows = [sort([V[n] for n∈N], rev=true);0]
        for flow ∈ map(+, flows[1:2:end], flows[2:2:end])
            rtime < 1 && break
            rvol += flow * rtime
            rtime -= 1+minDist
        end
        # Stop if no chance of beating best
        minv + rvol ≤ maxv && continue

        nflow = 0
        if w1 == 0 && n1 ∈ N
            nflow += V[n1]
            w1 = 1
            N = filter(!=(n1), N)
        end
        if w2 == 0 && n2 ∈ N
            nflow += V[n2]
            w2 = 1
            N = filter(!=(n2), N)
        end
        N1 = w1 > 0 ? [n1] : N
        N2 = w2 > 0 ? [n2] : N

        for nn1 ∈ N1, nn2 ∈ N2
            ww1 = nn1==n1 ? w1-1 : G2[n1][nn1]-1
            ww2 = nn2==n2 ? w2-1 : G2[n2][nn2]-1
            push!(Q, (t-1, flow, nflow, vol+flow, nn1, nn2, ww1, ww2, N))
        end
    end
    println("Part 2: ", maxv)
end