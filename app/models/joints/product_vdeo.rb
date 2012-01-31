class ProductVdeo < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :product
  belongs_to :vdeo
 
  #--- validations
  validates_presence_of :product
  validates_presence_of :vdeo
  validates_uniqueness_of :product_id, :scope => :vdeo_id
  validates_uniqueness_of :vdeo_id, :scope => :product_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.product
  end
 
  def secondary
     return self.vdeo
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
