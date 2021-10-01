include("..\\common\\movements.jl")
function find_hole!(r::Robot)
    steps = 1
    sides = [Ost, West]
    border::Bool = false
    while isborder(r, Nord)
        for side in sides
            movements!(r, steps, side; northern=true)
            steps += 1
            if !isborder(r, Nord)
                break
            end
        end
    end
end