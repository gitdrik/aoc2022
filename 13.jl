open("13.txt") do f
    function compare(L, R)
        L==R && return nothing
        L == [] && return true
        R == [] && return false
        if typeof(L)==typeof(R)==Int
            L < R && return true            
            L > R && return false
        end
        L, R = deepcopy(L), deepcopy(R)
        typeof(L)==Int && (L = [L])
        typeof(R)==Int && (R = [R])
        ans = compare(popfirst!(L), popfirst!(R))
        ans != nothing && return ans
        return compare(L, R)
    end

    function insort!(P, p)
        done = false
        for i ∈ eachindex(P)
            if compare(p, P[i])
                splice!(P, i:i-1, [p])
                done = true
                break
            end
        end
        !done && (push!(P, p))
        return P
    end

    P1, P2 = [], []
    while !eof(f)
        L = eval(Meta.parse(readline(f)))
        R = eval(Meta.parse(readline(f)))
        push!(P1, [L, R])
        insort!(P2, L)
        insort!(P2, R)
        readline(f)
    end

    println("Part 1: ", sum(findall([compare(L,R) for (L,R) ∈ P1])))

    insort!(P2, [[2]])
    insort!(P2, [[6]])
    println("Part 2: ", findfirst(==([[2]]), P2) * findfirst(==([[6]]), P2))
end