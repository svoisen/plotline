using Luxor

function catmullrompoint(p0::Point, p1::Point, p2::Point, p3::Point, t::Float64)
    t2 = t * t
    t3 = t2 * t
    
    a = -0.5 * p0 + 1.5 * p1 - 1.5 * p2 + 0.5 * p3
    b = p0 - 2.5 * p1 + 2 * p2 - 0.5 * p3
    c = -0.5 * p0 + 0.5 * p2
    d = p1
    
    return a * t3 + b * t2 + c * t + d
end

"""
    catmullromspline(points::Vector{Point}, segments::Int=20)

Creates a Catmull-Rom spline through a set of points.
"""
function catmullromspline(points::Vector{Point}, segments::Int=20)
    if length(points) < 4
        println("A Catmull-Rom spline requires at least 4 points.")
        return
    end
    
    spline_pts = Vector{Point}()
    push!(spline_pts, points[2])
    
    # Generate spline segments
    for i in 1:length(points) - 3
        p0, p1, p2, p3 = points[i:i+3]
        
        # Add points along the spline segment
        for j in 1:segments
            t = j / segments
            pt = catmullrompoint(p0, p1, p2, p3, t)
            push!(spline_pts, pt)
        end
    end

    return spline_pts
end