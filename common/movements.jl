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
function movements!(r::Robot, side::HorizonSide, steps::Integer)::Nothing
    for _ = 1:steps
        move!(r, side)
    end
end

"""
Moving a robot on a specified number of steps or till the marker
"""
function movements!(r::Robot, steps::Integer, side::HorizonSide; marker::Bool = true)::Nothing
    if marker
        for _ = 1:steps
            move!(r, side)
            if ismarker(r)
                break
            end
        end
    end
end

"""
Moving a robot on a specified number of steps or till northern border 
"""
function movements!(r::Robot, steps::Integer, side::HorizonSide; northern::Bool = true)::Nothing
    if northern
        for _ = 1:steps
            move!(r, side)
            if !isborder(r, Nord)
                break
            end
        end
    end
end
