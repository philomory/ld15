module LD15
  module Actions
    Attack = Struct.new(:target)
    Dig = Struct.new(:pattern,:dir)
  end
end