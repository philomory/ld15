# The modules in this file represent various constants that are referred to
# throughout the codebase.

module LD15
  module Sizes
    TileHeight = 32
    TileWidth  = 32
    SidebarWidth = 220
    SidebarHeight = 640
    SidebarItemWidth = 200
    SidebarItemHeight = 32
    SidebarEdge = 640
    SidebarMargin = (SidebarWidth - SidebarItemWidth)/2
    SidebarItemEdge = SidebarEdge + SidebarMargin
  end
  # ZOrder provides constants for use in Z-coordinates for draw calls.
  module ZOrder
    Background = 0
    Terrain = 1
    Highlight = 2
    Units = 3
    Effects = 4
    SidebarMenu = 5
    SidebarItems = 6
    Splash = 97
    TopMessage = 98
    Pointer = 99
    Fade = 100
  end #module ZOrder
  module Color
    MoveHighlight = 0x779aFFFF
    ValidDestHighlight = 0xAA002FFF
    InvalidDestHighlight = 0xAADB2400
    ActiveUnitHighlight = 0xAA00FF00
  end
  
  # Not sure if we're going to need to have an actual Faction class, doesn't seem necessary.
  module Factions
    Player = 0
    Enemy  = 1
  end
  
end