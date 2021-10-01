include("..\\common\\movements.jl")
function find_marker!(r::Robot)
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
            movements!(r, numsteps, side; marker=true)
            if odd
                numsteps += 1
            end
            odd = !odd
        end
    end
end