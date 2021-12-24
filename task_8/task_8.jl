include("..\\common\\movements.jl")

solve(r) = find_hole!(r)
function find_hole!(r)
    steps = 1
    sides = [Ost, West]
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