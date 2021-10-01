include("..\\common\\movements.jl")
function find_marker!(r::Robot)
    sides = [Nord, Ost, Sud, West]
    numsteps = 1
    while true
        for side in sides
            if ismarker(r)
                break
            end
            movements!(r, numsteps, side; marker=true)
            if side == West || side == Ost
                numsteps += 1
            end
        end
    end
end