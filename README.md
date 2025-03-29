# Plotline

A collection of utilities for pen plotter artwork in Julia, designed to extend the functionality of [Luxor.jl](https://github.com/JuliaGraphics/Luxor.jl).

## Overview

Plotline provides specialized functions for creating and manipulating geometric shapes and patterns commonly used in pen plotter art. It builds on Luxor's excellent drawing capabilities with tools specifically designed for the constraints and aesthetic of pen plotters.

## Features

- **Hatching**: Create controlled hatching patterns within polygons
  - Standard parallel line hatching with customizable angle and spacing
  - Single-line continuous hatching for fills
  
- **Polygon Operations**: Specialized geometric operations for polygonal shapes
  - Create inset/offset polygons with controlled distance
  - Polygon manipulation utilities designed for plotter-friendly output

## Installation

```julia
using Pkg
Pkg.add(url="https://github.com/svoisen/Plotline")
```

## Dependencies

- [Luxor.jl](https://github.com/JuliaGraphics/Luxor.jl)
- [Clipper.jl](https://github.com/JuliaGeometry/Clipper.jl)

## License

This project is licensed under the MIT License - see the LICENSE file for details.