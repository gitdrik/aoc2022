open("13.txt") do f
    P1, P2 = [], []
    while !eof(f)
        L = eval(Meta.parse(readline(f)))
        R = eval(Meta.parse(readline(f)))
        push!(P1, [L, R])
        push!(P2, L, R)
        readline(f)
    end

    function compare(L, R)
        L==R && return nothing
        L == [] && return true
        R == [] && return false
        typeof(L)==typeof(R)==Int && return L < R
        L, R = deepcopy(L), deepcopy(R)
        typeof(L)==Int && (L = [L])
        typeof(R)==Int && (R = [R])
        ans = compare(popfirst!(L), popfirst!(R))
        ans != nothing && return ans
        return compare(L, R)
    end

    println("Part 1: ", sum(findall([compare(L,R) for (L,R) ∈ P1])))

    push!(P2, [[2]], [[6]])
    sort!(P2, lt = compare)
    println("Part 2: ", findfirst(==([[2]]), P2) * findfirst(==([[6]]), P2))
end