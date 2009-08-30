module LD15
  class SidebarMenu
    def initialize(&blk)
      @parent = eval('self',blk.binding,__FILE__,__LINE__)
      @items_array  = []
      blk.call(self)
    end
    
    def add(title,&blk)
      x = Sizes::SidebarItemEdge
      y = Sizes::SidebarMargin + Sizes::SidebarItemHeight * @items_array.length
      SidebarItem.new(title,x,y,Sizes::SidebarItemWidth,Sizes::SidebarItemHeight,&blk)
    end
    
    def each
      @items_array.each do |item|
        yield item
      end
    end
    
    def click
    end
    
  end
end