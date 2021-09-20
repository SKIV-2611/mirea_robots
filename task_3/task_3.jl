function put_all_markers!(r::Robot)::Nothing
    coords::Tuple{Integer, Integer} = move_to_SW_corner!(r)
    mark_all_field!(r)
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

function switch_direction!(side::HorizonSide, r::Robot)::HorizonSide
    move!(r, Nord)
    if side == West
        return Ost
    else
        return West
    end
end

include("..\\common\\movements.jl")
function move_to_SW_corner!(r::Robot)::Tuple{Integer, Integer}
    y = movements!(r, Sud)
    x = movements!(r, West)
    return (x, y)
end

function move_back!(r::Robot, initial_coords::Tuple{Integer, Integer})::Nothing
    move_to_SW_corner!(r)
    movements!(r, initial_coords[1], West)
    movements!(r, initial_coords[2], Nord)
end