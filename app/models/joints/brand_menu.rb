class BrandMenu < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :brand
  belongs_to :menu, :class_name => 'Bubble'
 
  #--- validations
  validates_presence_of :brand
  validates_presence_of :menu
  validates_uniqueness_of :brand_id, :scope => :menu_id
  validates_uniqueness_of :menu_id, :scope => :brand_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.brand
  end
 
  def secondary
     return self.menu
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
