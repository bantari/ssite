class ProductMenu < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :product
  belongs_to :menu, :class_name => 'Bubble'
 
  #--- validations
  validates_presence_of :product
  validates_presence_of :menu
  validates_uniqueness_of :product_id, :scope => :menu_id
  validates_uniqueness_of :menu_id, :scope => :product_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.product
  end
 
  def secondary
     return self.menu
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
