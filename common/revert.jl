function revert!(side::HorizonSide)::HorizonSide
    return HorizonSide((Int(side) + 2) % 4)
end