open("22.txt") do f
    M = Array{Char}(undef, 200, 150)
    for r ∈ 1:200
        M[r,:] = collect(readline(f))
    end
    @assert readline(f) == ""
    path = readline(f)
    r, c = (1, 51)
    dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    dir = 1
    while !isempty(path)
        if path[1]=='R'
            dir = mod1(dir+1, 4)
            popleft!(path)
        elseif path[1]=='L'
            dir = mod1(dir-1, 4)
            popleft!(path)
        else
            n = ""
            while !isempty(path) && path[1]∈'0':'9'
                n *= popleft!(path)
            end
            n = parse(Int, n)
            dr, dc = dirs(dir)
            for _ ∈ 1:n
                if M[r+dr, c+dc]==' '

                end
                if M[r+dr, c+dc]=='.'
                    r += dr
                    c += dc
                elseif M[r+dr, c+dc]=='#'
                    break
                end
            end
                
