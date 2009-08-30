require 'gosu'

module LD15
  class SidebarItem
    attr_reader :title, :action, :x, :y, :width, :height
    def initialize(title,x,y,width,height,&blk)
      @title,@x,@y,@width,@height = title,x,y,width,height
      trunc = self.wordtrunc(@title,@width,Gosu::Font.new(MainWindow.instance,Gosu::default_font_name,height-4))
      @title_image = Gosu::Image.from_text(MainWindow.instance,trunc,Gosu::default_font_name,height-4)
      @action = blk
    end
    
    def draw
      @title_image.draw(@x,@y,ZOrder::SidebarItems)
    end
    
    def clicked
      @action.call
    end
    
    def include?(x_pos,y_pos)
      return x_pos.in?(@x...@x+@width) && y_pos.in?(@y...@y+@height)
    end
    
    def wordtrunc(name,width,font)
      char_array = name.split('')
      text = char_array.shift
      char_array.each do |char|
        if font.text_width("#{text}#{char}") < width
          text << char
        else
          break
        end
      end
      return text
    end
     
  end
end



