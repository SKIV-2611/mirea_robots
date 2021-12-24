function solve(r::Robot)
    cr = CoordRobot(r, Coord(0, 0))
    get_coord(cr)
    br = BorderRobot(cr)
    move_to_SW_corner!(br)
    side = move_to_rectangle!(cr)
    pmr = PutmarkersRobot(br)
    mark_rectangle!(pmr, side)
    #move_back!(cr)
end

function move_to_SW_corner!(cr)
    movements!(cr, West)
    movements!(cr, Sud)
end

function move_to_rectangle!(cr)::HorizonSide
    side = Ost
    while !isborder(cr, Nord)
        while !isborder(cr, Nord) && !isborder(cr, side)
            move!(cr, side)
        end
        side = inverse!(side)
        if !isborder(cr, Nord)
            move!(cr, Nord)
        end
    end
    return side
end

function mark_rectangle!(pmr::PutmarkersRobot, begin_side)
    side = begin_side
    while true
        border_side = (isborder(pmr, right!(side))) ? right!(side) : left!(side)
        movements!(()->!isborder(pmr, border_side), pmr, side)
        side = (Int(right!(side)) == Int(border_side)) ? border_side : inverse!(border_side)
    end
    try_move!(pmr, inverse!(bedin_side))
    movements!(()->!isborder(pmr, Nord), pmr, West)
end

function move_back!(cr::CoordRobot)

    x, y = get_coord(cr)
    movements!(cr, x_side, abs(x))
    movements!(cr, y_side, abs(y))
end