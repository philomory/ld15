# The modules in this file represent various constants that are referred to
# throughout the codebase.

module LD15
  module Sizes
    TileHeight = 32
    TileWidth  = 32
  end
  # ZOrder provides constants for use in Z-coordinates for draw calls.
  module ZOrder
    Background = 0
    Terrain = 1
    Highlight = 2
    Units = 3
    Effects = 4
    HUD = 5
    Splash = 98
    TopMessage = 99
    Fade = 100
  end #module ZOrder
end