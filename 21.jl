open("21.txt") do f
    M = Dict(s[1]=>s[2] for s ∈ split.(eachline(f), ": "))

    function yell(s, h=Inf)
        h != Inf && s=="humn" && return h
        M[s][1] ∈ '0':'9' && return parse(Int, M[s])
        ss = split(M[s])
        ss[2] == "+" ? (return yell(ss[1], h) + yell(ss[3], h)) :
        ss[2] == "-" ? (return yell(ss[1], h) - yell(ss[3], h)) :
        ss[2] == "*" ? (return yell(ss[1], h) * yell(ss[3], h)) :
        ss[2] == "/" ? (return yell(ss[1], h) // yell(ss[3], h)) : nothing
    end
    println("Part 1: ", Int(yell("root")))

    a, _, b = split(M["root"])
    # yell(b) == yell(a, h) == k*h + m
    m = yell(a, 0)
    k = (yell(a, 1) - m)
    h = (yell(b) - m) // k
    @assert yell(a, h) == yell(b)
    println("Part 2: ", Int(h))
end