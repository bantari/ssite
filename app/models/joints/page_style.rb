class PageStyle < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :page
  belongs_to :style
 
  #--- validations
  validates_presence_of :page
  validates_presence_of :style
  validates_uniqueness_of :page_id, :scope => :style_id
  validates_uniqueness_of :style_id, :scope => :page_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.page
  end
 
  def secondary
     return self.style
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
