import Luxor as L
import CatmullRom as CR

"""
    sketchyline(startpt::L.Point, endpt::L.Point, slop::Real)

Draw a sketchy (wavy) line between two points with a given slop.
"""
function sketchyline(startpt::L.Point, endpt::L.Point, slop::Real = 2mm)
    # Calculate the points along the line at 1/4 length intervals
    points = [L.Point(startpt.x + (endpt.x - startpt.x) * i / 4, startpt.y + (endpt.y - startpt.y) * i / 4) for i in 0:4]

    # Add some random slop to each point
    points = [L.Point(p.x + randombetween(-slop, slop), p.y + randombetween(-slop, slop)) for p in points]

    # Use a Catmull-Rom spline to create a smooth curve through the points
    spline_points = [(p.x, p.y) for p in points]
    cxs, cys = CR.catmullrom(spline_points)

    return L.Path([L.Point(cx, cy) for (cx, cy) in zip(cxs, cys)])
end