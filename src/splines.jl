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
    catmullromspline(points::Vector{Point}, segments::Int=20, closed::Bool=false)

Creates a Catmull-Rom spline through a set of points.
If closed is true, the spline will form a closed loop connecting the last point back to the first.
"""
function catmullromspline(points::Vector{Point}, segments::Int=20, closed::Bool=false)
    n = length(points)
    
    if closed && n < 3
        println("A closed Catmull-Rom spline requires at least 3 points.")
        return
    elseif !closed && n < 4
        println("An open Catmull-Rom spline requires at least 4 points.")
        return
    end
    
    spline_pts = Vector{Point}()
    
    if closed
        # Create a wrapped array of points for the closed spline
        wrapped_points = Vector{Point}()
        
        # For a closed spline, we need to wrap around the points
        # Last point connects back to first, so we need points[n-1], points[n], points[1], points[2]
        push!(wrapped_points, points[n-1], points[n])
        append!(wrapped_points, points)
        push!(wrapped_points, points[1], points[2])
        
        # Start the spline at the actual first point
        push!(spline_pts, points[1])
        
        # Generate spline segments for the wrapped points
        for i in 2:n+1
            p0, p1, p2, p3 = wrapped_points[i-1:i+2]
            
            # Add points along the spline segment
            for j in 1:segments
                t = j / segments
                pt = catmullrompoint(p0, p1, p2, p3, t)
                push!(spline_pts, pt)
            end
        end
    else
        # Original open spline behavior
        push!(spline_pts, points[2])
        
        # Generate spline segments
        for i in 1:n-3
            p0, p1, p2, p3 = points[i:i+3]
            
            # Add points along the spline segment
            for j in 1:segments
                t = j / segments
                pt = catmullrompoint(p0, p1, p2, p3, t)
                push!(spline_pts, pt)
            end
        end
    end

    return spline_pts
end