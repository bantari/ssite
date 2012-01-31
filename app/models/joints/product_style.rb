class ProductStyle < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :product
  belongs_to :style
 
  #--- validations
  validates_presence_of :product
  validates_presence_of :style
  validates_uniqueness_of :product_id, :scope => :style_id
  validates_uniqueness_of :style_id, :scope => :product_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.product
  end
 
  def secondary
     return self.style
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
