import Luxor as L
import GeoInterface as GI
import GeometryOps as GO

"""
    prepare_hatch(polygon::Vector{L.Point}, angle::Real, pitch::Real)

Prepare a polygon for hatch lines at a given angle and pitch.
This function calculates the bounding box and other parameters needed for the hatch.
"""
function prepare_hatch(polygon::Vector{L.Point}, angle::Real, pitch::Real)
    bbox = L.BoundingBox(polygon)
    width = (L.boxtopright(bbox) - L.boxtopleft(bbox))[1]
    height = (L.boxbottomleft(bbox) - L.boxtopleft(bbox))[2]
    center = L.boxmiddlecenter(bbox)

    diagonal = √(width^2 + height^2)
    theta = angle * π / 180

    # Calculate perpendicular direction to the hatch lines
    perp_x, perp_y = cos(theta + π/2), sin(theta + π/2)

    # Calculate the starting position relative to the center
    # Start far enough to cover the entire polygon
    start_position = center - L.Point(diagonal * perp_x, diagonal * perp_y)

    # Calculate the number of lines needed (with some extra for safety)
    num_lines = ceil(Int, 2 * diagonal / pitch) + 4

    # Vector in the direction of the hatch lines
    line_direction = L.Point(cos(theta), sin(theta))
    
    return start_position, diagonal, perp_x, perp_y, num_lines, line_direction
end

"""
    hatch(polygon::Vector{L.Point}, angle::Real, pitch::Real)

Fill a polygon with hatch lines at a given angle and pitch.
"""
function hatch(polygon::Vector{L.Point}, angle::Real, pitch::Real)
    start_position, diagonal, perp_x, perp_y, num_lines, line_direction = prepare_hatch(polygon, angle, pitch)

    # Basic hatching can rely on Luxor's built-in clipping functionality
    L.gsave()
    L.newpath()
    L.poly(polygon, :clip)
    
    for i in 0:num_lines
        # Calculate current position along perpendicular direction
        current_pos = start_position + L.Point(i * pitch * perp_x, i * pitch * perp_y)

        # Calculate start and end points of the line (extended beyond bbox)
        line_start = current_pos - (diagonal * line_direction)
        line_end = current_pos + (diagonal * line_direction)
        
        L.line(line_start, line_end, :stroke)
    end
    
    L.grestore()
end

function sketchyhatch(polygon::Vector{L.Point}, angle::Real, pitch::Real, slop::Real = 0.5mm)
    start_position, diagonal, perp_x, perp_y, num_lines, line_direction = prepare_hatch(polygon, angle, pitch)

    # For each hatch line, calculate the intersection points with the polygon
    # Then, use sketchline to draw the line between the intersection points

    # Convert polygon to GeoInterface geometry
    gipoly = GI.LinearRing([(p.x, p.y) for p in polygon])

    for i in 0:num_lines
        current_pos = start_position + L.Point(i * pitch * perp_x, i * pitch * perp_y)

        # Calculate start and end points of the line (extended beyond bbox)
        line_start = current_pos - (diagonal * line_direction)
        line_end = current_pos + (diagonal * line_direction)

        giline = GI.Line([(line_start.x, line_start.y), (line_end.x, line_end.y)])
        intersection = GO.intersection(giline, gipoly, target = GI.PointTrait())
        if intersection === nothing || length(intersection) < 2
            # No intersection or not enough points to draw a line
            continue
        end

        intersectionpt1 = GI.coordinates(intersection[1])
        intersectionpt2 = GI.coordinates(intersection[2])

        p = sketchyline(Point(intersectionpt1[1], intersectionpt1[2]), Point(intersectionpt2[1], intersectionpt2[2]), slop)
        drawpath(p)
        strokepath()
    end
end