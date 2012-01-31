class CategoryMenu < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :category
  belongs_to :menu, :class_name => 'Bubble'
 
  #--- validations
  validates_presence_of :category
  validates_presence_of :menu
  validates_uniqueness_of :category_id, :scope => :menu_id
  validates_uniqueness_of :menu_id, :scope => :category_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.category
  end
 
  def secondary
     return self.menu
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
