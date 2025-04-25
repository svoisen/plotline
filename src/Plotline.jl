module Plotline

include("hatch.jl")
include("offset.jl")
include("random.jl")
include("splines.jl")

export hatch, offset,
       pointcloud, randompointincircle,
       randompointsincircle, distpointsincircle,
       randompointinellipse, randompointsinellipse,
       distpointsinellipse, catmullromspline

end
