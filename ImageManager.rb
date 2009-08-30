#require 'gosu'

module LD15
  module ImageManager
    IMAGES = {}
    module_function
    def load_images
    
      %w{dirt floor wall pointer}.each do |key|
        self.add_image(key)
      end
      
      %w{digger soldier}.each do |unit|
        %w{north south east west}.each do |dir|
          self.add_image("#{unit}-#{dir}")
        end
      end
    end
    
    def add_image(key)
      path = File.join('media',key + '.png')
      IMAGES[key] = Gosu::Image.new(MainWindow.instance,path,true)
    end
    
    def image(key)
      IMAGES[key]
    end
  end
end