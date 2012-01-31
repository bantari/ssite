class ProductComponent < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :product
  belongs_to :component, :class_name => 'Product'
 
  #--- validations
  validates_presence_of :product
  validates_presence_of :component
  validates_uniqueness_of :product_id, :scope => :component_id
  validates_uniqueness_of :component_id, :scope => :product_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.product
  end
 
  def secondary
     return self.component
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
