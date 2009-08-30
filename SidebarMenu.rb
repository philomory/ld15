require 'SidebarItem'
require 'SidebarItemDisabled'

module LD15
  class SidebarMenu
    def initialize(title,&blk)
      @title = title
      @title_image  = Gosu::Image.from_text(MainWindow.instance,@title,Gosu::default_font_name,Sizes::SidebarItemHeight-4,2,Sizes::SidebarItemWidth,:center)
      @parent = eval('self',blk.binding,__FILE__,__LINE__)
      @items_array  = []
      @key_equivalents = {}
      blk.call(self)
    end
    
    def add(title,*key_equivs,&blk)
      x = Sizes::SidebarItemEdge
      y = Sizes::SidebarMargin + @title_image.height + 4 + Sizes::SidebarItemHeight * @items_array.length
      item = SidebarItem.new(title,x,y,Sizes::SidebarItemWidth,Sizes::SidebarItemHeight,&blk)
      @items_array << item
      key_equivs.each do |key|
        @key_equivalents[key] = item
      end    
    end
    
    def disabled(title)
      x = Sizes::SidebarItemEdge
      y = Sizes::SidebarMargin + @title_image.height + 4 + Sizes::SidebarItemHeight * @items_array.length
      item = SidebarItemDisabled.new(title,x,y,Sizes::SidebarItemWidth,Sizes::SidebarItemHeight) {}
      @items_array << item
    end
    
    def key_only(*key_equivs,&blk)
      key_equivs.each do |key|
        @key_equivalents[key] = blk
      end
    end
    
    def button_down(id)
      item = @key_equivalents[id]
      if item
        item.call
      end
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
  end
end