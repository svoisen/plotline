import Luxor as L

using Clipper

function offset(polygon::Vector{L.Point}, delta::Real)
    # Convert Luxor points to Clipper points using IntPoint
    int_poly = [IntPoint(p..., 1, 3) for p in polygon]
    co = ClipperOffset()

    # Close the polygon
    add_path!(co, int_poly, JoinTypeRound, EndTypeClosedPolygon)

    clipped = execute(co, delta * 100)
    if length(clipped) == 0
        return polygon
    end

    int_offset_poly = clipped[1]

    # Convert back to Luxor points
    offset_poly = L.Point.(tofloat.(int_offset_poly, 1, 3))

    return offset_poly
end