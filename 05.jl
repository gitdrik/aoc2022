open("05.txt") do f
    S = [[],[],[],[],[],[],[],[],[]]
    for i ∈ 1:8
        l = readline(f)
        for j ∈ 0:8
            l[2+j*4] ∈ 'A':'Z' && pushfirst!(S[j+1], l[2+j*4])
        end
    end
    readline(f)
    readline(f)
    S2 = deepcopy(S)
    while !eof(f)
        l = readline(f)
        a, b, c = parse.(Int, split(l)[2:2:6])
        CM9001 = []
        for i ∈ 1:a
            push!(S[c], pop!(S[b]))
            push!(CM9001, pop!(S2[b]))
        end
        for i ∈ 1:a
            push!(S2[c], pop!(CM9001))
        end
    end
    println("Part 1: ", join([s[end] for s ∈ S]))
    println("Part 2: ", join([s[end] for s ∈ S2]))
end