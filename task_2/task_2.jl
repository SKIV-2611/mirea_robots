"""
Задача 2:
Дано: Робот находится в произвольной клетке поля (без внутренних перегородок и маркеров)
Результат: Робот - в исходном положении, и все клетки по периметру внешней рамки промаркированы

"""
function move_to_border!(r::Robot)
    i::Integer = 0
    back::HorizonSide = HorizonSide(3)
    while !isborder(r, back)
        move!(r, back)
        i += 1
    end
    back = revert!(back)
    border!(r)
    for _ = 1:i
        move!(r, back)
    end
    
end

function border!(r::Robot)
    for i = 0:3
        side::HorizonSide = HorizonSide(i)
        while !isborder(r, side)
            if !ismarker(r)
                putmarker!(r)
            end
            move!(r, side)
        end
    end
    while !ismarker(r)
        putmarker!(r)
        move!(r, HorizonSide(0))
    end
end

function revert!(side::HorizonSide)::HorizonSide
    return HorizonSide((Int(side) + 2) % 4)
end