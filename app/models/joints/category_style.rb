class CategoryStyle < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :category
  belongs_to :style
 
  #--- validations
  validates_presence_of :category
  validates_presence_of :style
  validates_uniqueness_of :category_id, :scope => :style_id
  validates_uniqueness_of :style_id, :scope => :category_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.category
  end
 
  def secondary
     return self.style
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
