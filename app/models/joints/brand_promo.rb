class BrandPromo < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :brand
  belongs_to :promo, :class_name => 'Bubble'
 
  #--- validations
  validates_presence_of :brand
  validates_presence_of :promo
  validates_uniqueness_of :brand_id, :scope => :promo_id
  validates_uniqueness_of :promo_id, :scope => :brand_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.brand
  end
 
  def secondary
     return self.promo
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
