class Translation
  include ActiveModel::Model
  
  attr_accessor :surface, :reading, :pos, :chg_surface, :chg_reading, :changed
end

