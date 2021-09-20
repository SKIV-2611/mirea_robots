"""
Moving a robot to border.
"""
function movements!(r::Robot, side::HorizonSide)::Integer
    i::Integer = 0
    while !isborder(r, side)
        move!(r, side)
        i += 1
    end
    return i
end

"""
Moving a robot on a specified number of steps
"""
function movements!(r::Robot, steps::Integer, side::HorizonSide)::Nothing
    for _ = 1:steps
        move!(r, side)
    end
end