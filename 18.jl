open("18.txt") do f
    N = Set([Tuple(parse.(Int, split(l,','))) for l ∈ eachline(f)])
    S = [(-1,0,0),(0,-1,0),(0,0,-1),(1,0,0),(0,1,0),(0,0,1)]
    println("Part 1: ", sum(sum(n.+s ∉ N for s ∈ S) for n ∈ N))

    minx, maxx = extrema([x for (x, _, _) ∈ N]) .+ (-1, 1)
    miny, maxy = extrema([y for (_, y, _) ∈ N]) .+ (-1, 1)
    minz, maxz = extrema([z for (_, _, z) ∈ N]) .+ (-1, 1)
    xr, yr, zr = minx:maxx, miny:maxy, minz:maxz

    p2 = 0
    seen = Set{Tuple{Int,Int,Int}}()
    Q = [(minx, miny, minz)]
    for p ∈ Q
        (any(p .∉ (xr, yr, zr)) || p ∈ seen) && continue
        push!(seen, p)
        p2 += sum(p .+ s ∈ N for s ∈ S)
        for n ∈ [p .+ s for s ∈ S]
            n ∉ N && push!(Q, n)
        end
    end
    println("Part 2: ", p2)
end