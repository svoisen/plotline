include("../src/Plotline.jl")

import .Plotline as P
using Luxor

@draw begin
    origin()

    radius = 5cm
    poly_sides = 100

    sethue("black")
    circle_poly = ngon(O, radius, poly_sides)
    strokepath()

    star_poly = star(O, 45, 5, 0.5, 0)
    strokepath()

    sethue("red")
    P.hatch(circle_poly, -45, 2mm)

    sethue("yellow")
    P.hatch(circle_poly, -45, 2mm, 1mm)

    sethue("blue")
    P.hatch(star_poly, 45, 1mm)

    finish()
    preview()
end