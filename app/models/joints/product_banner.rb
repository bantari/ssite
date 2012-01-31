class ProductBanner < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :product
  belongs_to :banner
 
  #--- validations
  validates_presence_of :product
  validates_presence_of :banner
  validates_uniqueness_of :product_id, :scope => :banner_id
  validates_uniqueness_of :banner_id, :scope => :product_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.product
  end
 
  def secondary
     return self.banner
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
