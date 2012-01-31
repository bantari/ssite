class CategorySuggestion < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :category
  belongs_to :suggestion, :class_name => 'Product'
 
  #--- validations
  validates_presence_of :category
  validates_presence_of :suggestion
  validates_uniqueness_of :category_id, :scope => :suggestion_id
  validates_uniqueness_of :suggestion_id, :scope => :category_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.category
  end
 
  def secondary
     return self.suggestion
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
