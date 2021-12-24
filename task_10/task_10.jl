function solve(r)
    get_temperature_marked!(r)
end

function get_temperature_marked!(r)
    cr = CoordRobot(r, Coord())
    move_to_SW_corner!(cr)
    average_temp = get_average_temp!(cr)
    print(average_temp)
    move_back!(cr)
end

function get_average_temp!(cr)
    temp = 0.0
    n = 0
    side = Ost
    while !isborder(r, Nord)
        if ismarker(cr)
            temp += temperature(cr)
            n += 1
        end
        while try_move!(cr, side)
            if ismarker(cr)
                temp += temperature(cr)
                n += 1
            end
        end
        try_move!(cr, Nord)
        side = inverse!(side)
    end
    if ismarker(cr)
        temp += temperature(cr)
        n += 1
    end
    while try_move!(cr, side)
        if ismarker(cr)
            temp += temperature(cr)
            n += 1
        end
    end
    temp /= n
    return temp
end

function move_to_SW_corner!(cr)
    movements!(cr, Sud)
    movements!(cr, West)
end

function move_back!(cr)
    move_to_SW_corner!(cr)
    x, y = get_coord(cr)
    movements!(cr, Nord, -y)
    movements!(cr, Ost, -x)
end