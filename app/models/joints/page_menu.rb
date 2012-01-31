class PageMenu < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :page
  belongs_to :menu, :class_name => 'Bubble'
 
  #--- validations
  validates_presence_of :page
  validates_presence_of :menu
  validates_uniqueness_of :page_id, :scope => :menu_id
  validates_uniqueness_of :menu_id, :scope => :page_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.page
  end
 
  def secondary
     return self.menu
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
