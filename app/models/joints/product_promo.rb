class ProductPromo < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :product
  belongs_to :promo, :class_name => 'Bubble'
 
  #--- validations
  validates_presence_of :product
  validates_presence_of :promo
  validates_uniqueness_of :product_id, :scope => :promo_id
  validates_uniqueness_of :promo_id, :scope => :product_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.product
  end
 
  def secondary
     return self.promo
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
