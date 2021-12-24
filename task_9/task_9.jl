include("..\\common\\movements.jl")

solve(r) = find_marker!(r)
function find_marker!(r)
    sides = [Nord, Ost, Sud, West]
    numsteps = 1
    odd::Bool = false
    marker::Bool = false
    while !marker
        for side in sides
            marker = ismarker(r)
            if marker
                break
            end
            n = 0
            while !ismarker(r) && n < numsteps
                move!(r, side)
                n += 1
            end
            if odd
                numsteps += 1
            end
            odd = !odd
        end
    end
end