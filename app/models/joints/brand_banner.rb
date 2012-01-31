class BrandBanner < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :brand
  belongs_to :banner
 
  #--- validations
  validates_presence_of :brand
  validates_presence_of :banner
  validates_uniqueness_of :brand_id, :scope => :banner_id
  validates_uniqueness_of :banner_id, :scope => :brand_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.brand
  end
 
  def secondary
     return self.banner
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
