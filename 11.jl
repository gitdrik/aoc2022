function monkeys()
    items =
    [
        [66, 59, 64, 51],
        [67, 61],
        [86, 93, 80, 70, 71, 81, 56],
        [94],
        [71, 92, 64],
        [58, 81, 92, 75, 56],
        [82, 98, 77, 94, 86, 81],
        [54, 95, 70, 93, 88, 93, 63, 50]
    ]
    op =
    [
        n -> n * 3,
        n -> n * 19,
        n -> n + 2,
        n -> n * n,
        n -> n + 8,
        n -> n + 6,
        n -> n + 7,
        n -> n + 4
    ]
    next =
    [
        n -> n%2==0 ? 2 : 5,
        n -> n%7==0 ? 4 : 6,
        n -> n%11==0 ? 5 : 1,
        n -> n%19==0 ? 8 : 7,
        n -> n%3==0 ? 6 : 2,
        n -> n%5==0 ? 4 : 7,
        n -> n%17==0 ? 8 : 3,
        n -> n%13==0 ? 3 : 1
    ]

    function throw(items, rounds, p1)
        ans = zeros(Int, 8)
        for _ ∈ 1:rounds, m ∈ 1:8
            while !isempty(items[m])
                ans[m] += 1
                n = popfirst!(items[m])
                n = p1 ? op[m](n) ÷ 3 : op[m](n) % 9699690
                push!(items[next[m](n)], n)
            end
        end
        sort!(ans)
        return ans[8]*ans[7]
    end
    println("Part 1: ", throw(deepcopy(items), 20, true))
    println("Part 2: ", throw(deepcopy(items), 10000, false))
end

monkeys()