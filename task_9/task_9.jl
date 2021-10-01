include("..\\common\\movements.jl")
function find_marker!(r::Robot)
    steps::Integer = 1
    while !ismarker(r)
        movements!(r, steps, Nord)
        if ismarker(r)
            break
        end
        movements!(r, steps, Ost)
        if ismarker(r)
            break
        end
        steps += 2
        movements!(r, steps, Sud)
        if ismarker(r)
            break
        end
        movements!(r, steps, West)
        steps += 2
    end
end