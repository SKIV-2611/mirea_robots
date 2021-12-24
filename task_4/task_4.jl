solve(r) = put_marker_ladder!(r)

function put_marker_ladder!(r)
    cr = CoordRobot(r, Coord(0, 0))
    br = BorderRobot(cr)
    move_to_SW_corner!(br)
    pmr = PutmarkersRobot(br)
    mark_ladder!(pmr)
    move_back!(cr)
end

function mark_ladder!(pmr)
    n = movements!(pmr, Ost)
    movements!(pmr, West, n)
    try_move!(pmr, Nord)
    n -= 1
    while !isborder(pmr, Nord) && n > 0
        movements!(pmr, Ost, n)
        movements!(pmr, West, n)
        n -= 1
        try_move!(pmr, Nord)
    end
    movements!(pmr, Ost, n)
end

function move_to_SW_corner!(br)
    movements!(br, Sud)
    movements!(br, West)
end

function move_back!(cr)
    move_to_SW_corner!(cr)
    movements!(cr, Ost, abs(get_coord(cr)[1]))
    movements!(cr, Nord, abs(get_coord(cr)[2]))
end