open("17.txt") do f
    J = readline(f)
    jlen = length(J)
    P =
    [
        BitMatrix([1 1 1 1]),
        BitMatrix([0 1 0; 1 1 1; 0 1 0]),
        BitMatrix([1 1 1; 0 0 1; 0 0 1]),
        BitMatrix([1 1 1 1])',
        BitMatrix([1 1; 1 1])
    ]

    function pprint(C, p, r, c, top)
        pr, pc = size(p)
        CV = deepcopy(C)
        CV[r:r+pr-1, c:c+pc-1] .|= p
        for rr ∈ top+5:-1:max(1, top-15)
            for cc ∈ 1:9
                print(CV[rr, cc] ? '█' : ' ')
            end
            println(rr)
        end
        sleep(0.05)
    end

    h1440 = 0
    t, top = 0, 1
    C = BitMatrix(fill(true, 10000, 9))
    C[2:end, 2:8] .= false
    for i ∈ 1:2022
        r, c = top+4, 4
        p = P[mod1(i, 5)]
        while true
            t += 1
            pr, pc = size(p)
            dc = J[mod1(t, jlen)]=='<' ? -1 : 1
            !any(p .& C[r:r+pr-1, c+dc:c+dc+pc-1]) && (c += dc)
            if any(p .& C[r-1:r+pr-2, c:c+pc-1])
                C[r:r+pr-1, c:c+pc-1] .|= p
                top = max(top, r+pr-1)
                break
            end
            r -= 1
        end
        i == 1440 && (h1440 = top-1)
        i == 2022 && (println("Part 1: ", top-1))
    end

    pieces = 1000000000000
    pperiod = 1720 # no of pieces per jets cycle
    nonperiodicalhight = pieces % pperiod # =1440
    deltah = 2729 # hight increase per 1720 rock period
    p2 = h1440 + deltah*(pieces÷pperiod)
    println("Part 2: ", p2)

end