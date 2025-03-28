import Luxor as L

using Clipper

function offset(polygon::Vector{L.Point}, delta::Real)
    int_poly = [IntPoint(p..., 1, 3) for p in polygon]
    co = ClipperOffset()
    add_path!(co, int_poly, JoinTypeRound, EndTypeClosedPolygon)
    int_offset_poly = execute(co, delta * 100)[1]
    offset_poly = L.Point.(tofloat.(int_offset_poly, 1, 3))

    return offset_poly
end