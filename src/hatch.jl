import Luxor as L

"""
    hatchfill(polygon::Vector{L.Point}, angle::Real, pitch::Real)

Fill a polygon with hatch lines at a given angle and pitch.
"""
function hatch(polygon::Vector{L.Point}, angle::Real, pitch::Real)
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
    nlines = ceil(Int, 2 * diagonal / pitch) + 4
    
    L.gsave()
    L.newpath()
    L.poly(polygon, :clip)

    # Vector in the direction of the hatch lines
    line_direction = L.Point(cos(theta), sin(theta))
    
    for i in 0:nlines
        # Calculate current position along perpendicular direction
        current_pos = start_position + L.Point(i * pitch * perp_x, i * pitch * perp_y)

        # Calculate start and end points of the line (extended beyond bbox)
        line_start = current_pos - (diagonal * line_direction)
        line_end = current_pos + (diagonal * line_direction)
        
        L.line(line_start, line_end, :stroke)
    end
    
    L.grestore()
end