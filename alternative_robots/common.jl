inverse!(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))
left!(side::HorizonSide) = HorizonSide(mod(Int(side)+1, 4))
right!(side::HorizonSide) = HorizonSide(mod(Int(side)+3, 4))

"""
try_move!(robot, side)::Bool

-- если это возможно, перемещает робота в соседнюю в направлении side клетку с обходом перегородок
-- если такое перемещение невозможно, робот возвращается в исходную клетку


"""
function try_move!(robot, side)::Bool
    if !isborder(robot, side)
        move!(robot, side)
        return true
    end
    left = left!(side)
    right = right!(side)
    if isborder(robot, left) || isborder(robot, right)
        return false
    end
    n = 0
    while isborder(robot, side) && !isborder(robot, left)
        move!(robot, left)
        n += 1
    end

    state = isborder(robot, side)
    if !state
        println("rectangle")
        move!(robot, side)
        while isborder(robot, right) && !isborder(robot, side)
            move!(robot, side)
        end
    end
    
    for _ = 1:n
        move!(robot, right)
    end
    return !state
end

"""
movements!(robot, side)

-- перемещает робота в заданном направлении "до упора" (пока возможно) и возвращает число сделанных шагов
"""
function movements!(robot, side)
    n = 0
    while try_move!(robot, side)
        n += 1
        println(n)
    end
    return n
end

"""
movements!(robot, side)

-- перемещает робота в заданном не более чем на max_num_steps шагов, пока это возможно, и возвращает число сделанных шагов
"""
function movements!(robot, side, max_num_steps::Integer)
    n=0
    while n < max_num_steps && try_move!(robot, side) # - в этом логическом выражении порядок аргументов важен!
        n += 1
    end
    return n
end


"""
movements!(stop_condition::Function, robot, side, max_num_steps) 

-- делает не более чем max_num_steps шагов в заданном направлении, пока выпоняется условие !stop_condition()==true", 
и возвращает число сделанных шагов

-- stop_condition - функция без аргументов, возвращающая логическое значение, определяет условие останова
"""
function movements!(stop_condition::Function, robot, side, max_num_steps)
    n = 0
    while n < max_num_steps && !stop_condition() && try_move!(robot, side) # - в этом логическом выражении порядок аргументов важен!
        n += 1
    end  
    return n 
end


"""
movements!(stop_condition::Function, robot, side) 

-- перемещает робота в заданном направлении пока возможен try_move! и пока выпоняется условие !stop_condition()==true", 
и возвращает число сделанных шагов

-- stop_condition - функция без аргументов, возвращающая логическое значение
"""
function movements!(stop_condition::Function, robot, side) 
    n=0
    while !stop_condition() && try_move!(robot,side)
        n += 1
    end
    return n
end


