module Plotline

include("hatch.jl")
include("offset.jl")
include("random.jl")

export hatchfill, offset,
       pointcloud, randompointincircle,
       randompointsincircle, distpointsincircle,
       randompointinellipse, randompointsinellipse,
       distpointsinellipse

end
