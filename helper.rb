# This file contains various odds and ends, most of which are not really
# specific to this project, such as creating consistency between ruby 1.8 and 
# 1.9

#A helper function, makes code more readable
class Object
  def in?(object)
    if object.respond_to?(:include?) then
      object.include? self
    else
      false
    end
  end #def in?
end #class Object

#allow Hash#key in 1.8
unless {}.respond_to?(:key)
  class Hash
    alias :key :index
  end
end

#alias to put enum_slice back into 1.9
require 'enumerator'
unless [].respond_to?(:enum_slice)
  module Enumerable
    alias :enum_slice :each_slice
  end
end

#another backported 1.9 feature for 1.8
unless {}.respond_to?(:default_proc=)
  class Hash
    def default_proc=(proc)
      initialize(&proc)
    end
  end  
end

def rot_cw(dir)
  {:north => :east,:east => :south, :south => :west, :west => :north}[dir]
end

def rot_180(dir)
  rot_cw(rot_cw(dir))
end

def rot_ccw(dir)
  rot_cw(rot_cw(rot_cw(dir)))
end

#helper hash to get Gosu button constant names
module OperationLambda

  
  GosuButtonIdNames = {}
  
  module_function
  def build_hash_of_gosu_button_id_names
    (Gosu.constants - ['MsNum',:MsNum]).each do |str|
      x = Gosu.const_get(str)
      if x.is_a? Fixnum
        GosuButtonIdNames[x] = str
      end
    end
  end
  
end