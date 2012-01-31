class BrandStyle < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :brand
  belongs_to :style
 
  #--- validations
  validates_presence_of :brand
  validates_presence_of :style
  validates_uniqueness_of :brand_id, :scope => :style_id
  validates_uniqueness_of :style_id, :scope => :brand_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.brand
  end
 
  def secondary
     return self.style
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
