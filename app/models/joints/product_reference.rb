class ProductReference < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :product
  belongs_to :reference, :class_name => 'Publication'
 
  #--- validations
  validates_presence_of :product
  validates_presence_of :reference
  validates_uniqueness_of :product_id, :scope => :reference_id
  validates_uniqueness_of :reference_id, :scope => :product_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.product
  end
 
  def secondary
     return self.reference
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
