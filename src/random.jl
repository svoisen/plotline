import Luxor as L

"""
    randombetween(a::Float64, b::Float64)

Generate a random number between `a` and `b`.
"""
function randombetween(a::Float64, b::Float64)
    return a + rand() * (b - a)
end

"""
    pointcloud(n::Int, minx::Float64=0., miny::Float64=0., maxx::Float64=400., maxy::Float64=400.)

Generate a point cloud of `n` points in a given rectangle.
"""
function pointcloud(n::Int, minx::Float64=0., miny::Float64=0., maxx::Float64=400., maxy::Float64=400.)
    return [L.randompoint(Point(minx, miny), Point(maxx, maxy)) for _ in 1:n]
end

"""
    randompointincircle(origin::L.Point, radius::Float64)

Generate a random point within a circle of given `radius` centered at `origin`.
"""
function randompointincircle(origin::L.Point, radius::Float64)
    Ø = rand(0:360) * π / 180.0
    r = rand() * radius
    x = origin.x + r * cos(Ø)
    y = origin.y + r * sin(Ø)
    return L.Point(x, y)
end

"""
    randompointsincircle(n::Int, origin::L.Point, radius::Float64)

Generate `n` points within a circle of given `radius` centered at `origin`.
"""
function randompointsincircle(n::Int, origin::L.Point, radius::Float64)
    points = []
    for _ in 1:n
        push!(points, randompointincircle(origin, radius))
    end
    return points
end

"""
    distpointsincircle(n::Int, origin::L.Point, radius::Float64, k::Int=10)

Generate `n` points within a circle of given `radius` centered at `origin`. Use
Mitchell's best candidate algorithm to ensure that the points are well distributed.
The algorithm works by generating `k` random points and selecting the one that is
the farthest from the existing points.
"""
function distpointsincircle(n::Int, origin::L.Point, radius::Float64, k::Int=10)
    points = [randompointincircle(origin, radius)]

    for _ in 2:n
        best_distance = 0.0
        best_point = nothing
        for _ in 1:k
            point = randompointincircle(origin, radius)
            distance = minimum(L.distance(point, p) for p in points)
            if distance > best_distance
                best_distance = distance
                best_point = point
            end
        end

        push!(points, best_point)
    end

    return points
end

"""
    randompointinellipse(origin::L.Point, a::Float64, b::Float64)

Generate a random point within an ellipse defined by its semi-major axis `a` and
semi-minor axis `b`, centered at `origin`.
"""
function randompointinellipse(origin::L.Point, a::Float64, b::Float64)
    Ø = rand(0:360) * π / 180.0
    r = rand() * a
    x = origin.x + r * cos(Ø)
    y = origin.y + (r / a) * b * sin(Ø)
    return L.Point(x, y)
end

"""
    randompointsinellipse(n::Int, origin::L.Point, a::Float64, b::Float64)

Generate `n` points within an ellipse defined by its semi-major axis `a` and
semi-minor axis `b`, centered at `origin`.
"""
function randompointsinellipse(n::Int, origin::L.Point, a::Float64, b::Float64)
    points = []
    for _ in 1:n
        push!(points, randompointinellipse(origin, a, b))
    end
    return points
end

"""
    distpointsinellipse(n::Int, origin::L.Point, a::Float64, b::Float64, k::Int=10)

Generate `n` points within an ellipse defined by its semi-major axis `a` and
semi-minor axis `b`, centered at `origin`. Use Mitchell's best candidate algorithm
to ensure that the points are well distributed. The algorithm works by generating
`k` random points and selecting the one that is the farthest from the existing points.
"""
function distpointsinellipse(n::Int, origin::L.Point, a::Float64, b::Float64, k::Int=10)
    points = [randompointinellipse(origin, a, b)]

    for _ in 2:n
        best_distance = 0.0
        best_point = nothing
        for _ in 1:k
            point = randompointinellipse(origin, a, b)
            distance = minimum(L.distance(point, p) for p in points)
            if distance > best_distance
                best_distance = distance
                best_point = point
            end
        end

        push!(points, best_point)
    end

    return points
end