"""
ДАНО: Робот - в произвольной клетке ограниченного прямоугольной рамкой поля без внутренних перегородок и маркеров.
РЕЗУЛЬТАТ: Робот - в исходном положении в центре косого креста (в форме X) из маркеров.
"""

function cross!(r::Robot)
    side_pairs = ((Nord, Ost), (Sud, Ost), (Sud, West), (Nord, West))
    for side in side_pairs
        line!(r, side)
    end
    putmarker!(r)
end

function line!(r::Robot, side::Union{NTuple{2, HorizonSide}, Vector{HorizonSide}})
    steps::Integer = putmarkers!(r, side)
    move_back!(r, side, steps)
end

function putmarkers!(r::Robot, side::Union{NTuple{2, HorizonSide}, Vector{HorizonSide}})::Integer
    steps = 0
    while !isborder_tuple(r, side)
        move_tuple!(r, side)
        putmarker!(r)
        steps += 1
    end
    return steps
end

function move_tuple!(r::Robot, side::Union{NTuple{2, HorizonSide}, Vector{HorizonSide}})
    move!(r, side[1])
    move!(r, side[2])
end

function isborder_tuple(r::Robot, side::Union{NTuple{2, HorizonSide}, Vector{HorizonSide}})::Bool
    return (isborder(r, side[1])) || (isborder(r, side[2]))
end
include("..\\common\\revert.jl")
function move_back!(r::Robot, side::Union{NTuple{2, HorizonSide}, Vector{HorizonSide}}, steps::Integer)
    side = revert!.(side)
    for _ = 1:steps
        move_tuple!(r, side)
    end
end