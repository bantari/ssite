class ProductSuggestion < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :product
  belongs_to :suggestion, :class_name => 'Product'
 
  #--- validations
  validates_presence_of :product
  validates_presence_of :suggestion
  validates_uniqueness_of :product_id, :scope => :suggestion_id
  validates_uniqueness_of :suggestion_id, :scope => :product_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.product
  end
 
  def secondary
     return self.suggestion
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
