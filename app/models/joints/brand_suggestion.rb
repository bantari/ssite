class BrandSuggestion < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :brand
  belongs_to :suggestion, :class_name => 'Product'
 
  #--- validations
  validates_presence_of :brand
  validates_presence_of :suggestion
  validates_uniqueness_of :brand_id, :scope => :suggestion_id
  validates_uniqueness_of :suggestion_id, :scope => :brand_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.brand
  end
 
  def secondary
     return self.suggestion
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
