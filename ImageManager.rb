require 'gosu'

module LD15
  module ImageManager
    IMAGES = {}
    module_function
    def load_images
      
      %w{dirt floor wall digger}.each do |key|
        path = File.join('media',key + '.png')
        IMAGES[key] = Gosu::Image.new(MainWindow.instance,path,true)
      end
    end
    
    def image(key)
      IMAGES[key]
    end
  end
end