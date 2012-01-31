class ProductImage < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :product
  belongs_to :image
 
  #--- validations
  validates_presence_of :product
  validates_presence_of :image
  validates_uniqueness_of :product_id, :scope => :image_id
  validates_uniqueness_of :image_id, :scope => :product_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.product
  end
 
  def secondary
     return self.image
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
