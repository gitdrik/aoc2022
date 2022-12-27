open("25.txt") do f
    s2int = Dict('2'=>2, '1'=>1, '0'=>0, '-'=>-1, '='=>-2)
    int2s = Dict([b=>a for (a, b) ∈ s2int])

    function snafuadd(A, B)
        d = 0
        ans = []
        while !isempty(A) || !isempty(B) || d != 0
            d += isempty(A) ? 0 : pop!(A)
            d += isempty(B) ? 0 : pop!(B)
            if d > 2
                pushfirst!(ans, d-5)
                d = 1
            elseif d < -2
                pushfirst!(ans, d+5)
                d = -1
            else
                pushfirst!(ans, d)
                d = 0
            end
        end
        return ans
    end

    S = []
    for l ∈ eachline(f)
        N = [s2int[c] for c ∈ l]
        S = snafuadd(S, N)
    end
    println("Part 1: ", join([int2s[d] for d ∈ S]))
end