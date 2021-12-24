solve!(r) = put_angle_markers!(r)

function put_angle_markers!(r)
    cr = CoordRobot(r, Coord())
    br = BorderRobot(cr)
    move_to_SW_corner!(br)
    mark_angles!(cr)
    move_back!(br)
end

function move_to_SW_corner!(br)
    movements!(br, Sud)
    movements!(br, West)
end

function mark_angles!(cr)
    for side in [Nord, Ost, Sud, West]
        putmarker!(cr)
        movements!(cr, side)
    end
end

function move_back!(br)
    move_to_SW_corner!(br)
    x, y = get_coord(br.robot)
    movements!(br, Nord, -y)
    movements!(br, Ost, -x)
end