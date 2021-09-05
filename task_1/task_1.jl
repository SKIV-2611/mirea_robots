"""
Making a cross with the center at the starting point
"""
function cross!(r::Robot)
    for i = 0:3
        directions!(r, HorizonSide(i))
    end
    putmarker!(r)
end

"""
Putting markers in direction specified by side::HorizonSide variable and returning the robot back to its initial position

"""
function directions!(r::Robot, side::HorizonSide)::Nothing
    while !isborder(r, side)
        move!(r, side)
        if !ismarker(r)
            putmarker!(r)
        end
    end
    side = reverse!(side)
    while ismarker(r)
        move!(r, side)
    end
end

"""
Reversing HorizonSide:
Nord <-> Sud,
West <-> East
"""
function reverse!(side::HorizonSide)::HorizonSide
    return HorizonSide((Int(side) + 2) % 4)
end