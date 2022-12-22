open("22.txt") do f
    M = fill(' ', 200, 150)
    for r ∈ 1:200
        l = collect(readline(f))
        M[r,eachindex(l)] = l
    end
    @assert readline(f) == ""
    path = readline(f)

    function next(r, c, dir)
        dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        dr, dc = dirs[dir]
        nr, nc = r, c
        while true
            nr, nc = mod1(nr+dr,200), mod1(nc+dc,150)
            M[nr, nc] != ' ' && return nr, nc, dir
        end
    end

    function next2(r, c, dir)
        dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        if r∈1:50 && c==51 && dir==3
            nr = 151-r
            nc = 1
            ndir = 1
        elseif r∈101:150 && c==1 && dir==3
            nr = 151-r
            nc = 51
            ndir = 1
        elseif r==1 && c∈51:100 && dir==4
            nr = 100+c
            nc = 1
            ndir = 1
        elseif r∈151:200 && c==1 && dir==3
            nr = 1
            nc = r-100
            ndir = 2
        elseif r==1 && c∈101:150 && dir==4
            nr = 200
            nc = c-100
            ndir = 4
        elseif r==200 && c∈1:50 && dir==2
            nr = 1
            nc = c+100
            ndir = 2
        elseif r∈1:50 && c==150 && dir==1
            nr = 151-r
            nc = 100
            ndir = 3
        elseif r∈101:150 && c==100 && dir==1
            nr = 151-r
            nc = 150
            ndir = 3
        elseif r==50 && c∈101:150 && dir==2
            nr = c-50
            nc = 100
            ndir = 3
        elseif r∈51:100 && c==100 && dir==1
            nr = 50
            nc = r+50
            ndir = 4
        elseif r∈51:100 && c==51 && dir==3
            nr = 101
            nc = r-50
            ndir = 2
        elseif r==101 && c∈1:50 && dir==4
            nr = c+50
            nc = 51
            ndir = 1
        elseif r==150 && c∈51:100 && dir==2
            nr = c+100
            nc = 50
            ndir = 3
        elseif r∈151:200 && c==50 && dir==1
            nr = 150
            nc = r-100
            ndir = 4
        else
            nr, nc = dirs[dir] .+ (r, c)
            ndir = dir
        end
        return nr, nc, ndir
    end

    function password(path, flat)
        r, c = (1, 51)
        path = collect(path)
        dir = 1
        while !isempty(path)
            if path[1]=='R'
                dir = mod1(dir+1, 4)
                popfirst!(path)
            elseif path[1]=='L'
                dir = mod1(dir-1, 4)
                popfirst!(path)
            else
                n = ""
                while !isempty(path) && path[1]∈'0':'9'
                    n *= popfirst!(path)
                end
                n = parse(Int, n)
                for _ ∈ 1:n
                    nr, nc, ndir = flat ? next(r, c, dir) : next2(r, c, dir)
                    if M[nr, nc]=='.'
                        r, c, dir = nr, nc, ndir
                    elseif M[nr, nc]=='#'
                        break
                    end
                end
            end
        end
        return 1000*r + 4*c + dir-1
    end
    println("Part 1: ", password(path, true))
    println("Part 2: ", password(path, false))

end