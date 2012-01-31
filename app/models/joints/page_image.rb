class PageImage < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :page
  belongs_to :image
 
  #--- validations
  validates_presence_of :page
  validates_presence_of :image
  validates_uniqueness_of :page_id, :scope => :image_id
  validates_uniqueness_of :image_id, :scope => :page_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.page
  end
 
  def secondary
     return self.image
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
