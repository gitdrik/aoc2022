open("20.txt") do f
    N = parse.(Int, readlines(f))

    function grovesum(N, mix)
        l = length(N)
        iN = collect(enumerate(N))
        for _ ∈ 1:mix
            for i ∈ 1:l
                j = findfirst(map(a->a[1]==i, iN))
                n = popat!(iN, j)
                insert!(iN, mod1(j+n[2],l-1), n)
            end
        end
        z = findfirst(map(a->a[2]==0, iN))
        return iN[mod1(z+1000,l)][2]+iN[mod1(z+2000,l)][2]+iN[mod1(z+3000,l)][2]
    end

    println("Part 1: ", grovesum(N, 1))
    println("Part 2: ", grovesum(N .* 811589153, 10))
end