open("13.txt") do f
    P = [eval(Meta.parse(l)) for l ∈ readlines(f) if l != ""]

    function compare(L, R)
        L==R && return nothing
        L==[] && return true
        R==[] && return false
        typeof(L)==typeof(R)==Int && return L < R
        typeof(L)==Int && (L = [L])
        typeof(R)==Int && (R = [R])
        ans = compare(L[1], R[1])
        ans != nothing && return ans
        return compare(L[2:end], R[2:end])
    end

    P1 = [compare(P[i], P[i+1]) for i ∈ 1:2:length(P)-1]
    println("Part 1: ", sum(findall(P1)))

    push!(P, [[2]], [[6]])
    sort!(P, lt = compare)
    println("Part 2: ", findfirst(==([[2]]), P) * findfirst(==([[6]]), P))
end
