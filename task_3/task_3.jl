function put_all_markers!(r::Robot)::Nothing
    coords::Tuple{Integer, Integer} = move_to_SW_corner!(r)
    mark_all_field!(r)
    move_to_SW!(r)
    move_back!(r, coords)
end

function mark_all_field!(r::Robot)::Nothing
    side::HorizonSide = Ost
    while !(isborder(r, Nord) && (isborder(r, West) || isborder(r, Ost)))
        mark_row!(r, side)
        side = switch_direction!(side, r)
    end
    mark_row!(r, side)
end

function mark_row!(r::Robot, side::HorizonSide)::Nothing
    while !isborder(r, side)
        putmarker!(r)
        move!(r, side)
    end
    putmarker!(r)
end



include("..\\common\\movements.jl")

function move_to_SW_corner!(r::Robot)::Tuple{Integer, Integer}
    x = movements!(r, West)
    y = movements!(r, Sud)
    return (x, y)
end
function move_to_SW!(r::Robot)
    movements!(r, West)
    movements!(r, Sud)
end

function move_back!(r::Robot, initial_coords::Tuple{Integer, Integer})::Nothing
    movements!(r, Ost, initial_coords[1])
    movements!(r, Nord, initial_coords[2])
end

include("..\\common\\revert.jl")
function switch_direction!(side::HorizonSide, r::Robot)::HorizonSide
    move!(r, Nord)
    side = revert!(side)
    return side
end