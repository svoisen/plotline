include("../src/Plotline.jl")

import .Plotline as P
using Luxor

@svg begin
origin()

radius = 100
poly_sides = 100

circle_poly = ngon(Point(0, 0), radius, poly_sides)

sethue("red")
P.hatchfill(circle_poly, -45, 2mm, 0)

finish()
preview()
end 8inch 8inch