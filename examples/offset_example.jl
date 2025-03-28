include("../src/Plotline.jl")

import .Plotline as P
using Luxor

@draw begin
    origin()

    radius = 5cm
    hexagon = ngon(O, radius, 6)
    strokepath()

    sethue("red")
    inset = P.offset(hexagon, -20.0)
    drawpath(polytopath(inset))
    strokepath()
end
