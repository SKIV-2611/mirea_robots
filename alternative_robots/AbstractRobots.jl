import HorizonSideRobots: HorizonSide, move!, isborder, putmarker!, ismarker, Robot, temperature


include("common.jl")

mutable struct Coord
    x::Int
    y::Int
end

Coord() = Coord(0, 0)

function move!(coord::Coord, side::HorizonSide)
    if side==Nord
        coord.y += 1
    elseif side==Sud
        coord.y -= 1
    elseif side==Ost
        coord.x += 1
    elseif side==West
        coord.x -= 1
    end
    nothing
end

get_coord(coord::Coord) = (coord.x, coord.y)

struct CoordRobot
    robot::Robot
    coord::Coord
end

function move!(robot::CoordRobot, side::HorizonSide)
    move!(robot.robot, side)
    move!(robot.coord, side)
end

isborder(robot::CoordRobot, side) = isborder(robot.robot, side)
putmarker!(robot::CoordRobot) = putmarker!(robot.robot)
ismarker(robot::CoordRobot) = ismarker(robot.robot)
temperature(robot::CoordRobot) = temperature(robot.robot)
get_coord(robot::CoordRobot) = get_coord(robot.coord)

struct BorderRobot{TypeRobot} # TypeRobot = Robot | CoordRobot
    robot::TypeRobot
end

get(robot::BorderRobot) = robot.robot
move!(robot::BorderRobot, side) = move!(robot.robot, side)
isborder(robot::BorderRobot, side) = isborder(robot.robot, side)
putmarker!(robot::BorderRobot) = putmarker!(robot.robot)
ismarker(robot::BorderRobot) = ismarker(robot.robot)
temperature(robot::BorderRobot) = temperature(robot.robot)
get_coord(robot::BorderRobot{CoordRobot}) = get_coord(robot.robot)

struct PutmarkersRobot{TypeRobot}
    robot::TypeRobot
end

get(robot::PutmarkersRobot) = robot.robot

function try_move!(robot::PutmarkersRobot, side::HorizonSide)::Bool
    putmarker!(robot.robot)
    if try_move!(robot.robot, side)
        putmarker!(robot.robot)
        return true
    end
    return false
end

get(robot::PutmarkersRobot) = robot.robot
move!(robot::PutmarkersRobot, side) = move!(robot.robot, side)
isborder(robot::PutmarkersRobot, side) = isborder(robot.robot, side)
putmarker!(robot::PutmarkersRobot) = putmarker!(robot.robot)
ismarker(robot::PutmarkersRobot) = ismarker(robot.robot)
temperature(robot::PutmarkersRobot) = temperature(robot.robot)