require 'Constants'
require 'SidebarItem'

module LD15
  class SidebarItemDisabled < SidebarItem
    def draw
      @title_image.draw(@x,@y,ZOrder::SidebarItems,1,1,Color::SidebarItemDisabled)
    end
  end
end