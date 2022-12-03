open("03.txt") do f
    R = readlines(f)
    p1 = 0
    for r ∈ R
        c = pop!(r[1:length(r)÷2] ∩ r[(1+length(r)÷2):end])
        p1 += islowercase(c) ? 1+c-'a' : 27+c-'A'
    end
    println(p1)
    p2 = 0
    for i ∈ 1:3:length(R)
        c = pop!(R[i] ∩ R[i+1] ∩ R[i+2])
        p2 += islowercase(c) ? 1+c-'a' : 27+c-'A'
    end
    println(p2)
end