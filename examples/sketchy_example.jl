using Luxor

include("../src/random.jl")
include("../src/sketchy.jl")
include("../src/hatch.jl")

width, height = 500, 500

@draw begin
    background("white")
    sethue("black")
    setline(1)
    origin(0, 0)

    # numlines = 100
    # for i in 0:numlines
    #     x = 0
    #     y = i / numlines * height
        
    #     local p = sketchyline(Point(x, y), Point(width, y), 0.5mm)
    #     drawpath(p)
    #     strokepath()
    # end

    r = poly([Point(100, 100), Point(200, 100), Point(200, 200), Point(100, 200), Point(100, 100)])
    sketchyhatch(r, 45, 5, 0.3mm)
end width height