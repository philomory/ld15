require 'SidebarItem'

module LD15
  class SidebarMenu
    def initialize(title,&blk)
      @title = title
      @title_image  = Gosu::Image.from_text(MainWindow.instance,@title,Gosu::default_font_name,Sizes::SidebarItemHeight-4,2,Sizes::SidebarItemWidth,:center)
      @parent = eval('self',blk.binding,__FILE__,__LINE__)
      @items_array  = []
      blk.call(self)
    end
    
    def add(title,&blk)
      x = Sizes::SidebarItemEdge
      y = Sizes::SidebarMargin + @title_image.height + 4 + Sizes::SidebarItemHeight * @items_array.length
      @items_array << SidebarItem.new(title,x,y,Sizes::SidebarItemWidth,Sizes::SidebarItemHeight,&blk)
    end
    
    def each
      @items_array.each do |item|
        yield item
      end
    end
    
    def draw
      @title_image.draw(Sizes::SidebarItemEdge,Sizes::SidebarMargin,ZOrder::SidebarItems)
      @items_array.each do |item|
        item.draw
      end
    end
    
    def click
    end
    
  end
end