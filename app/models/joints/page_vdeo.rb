class PageVdeo < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :page
  belongs_to :vdeo
 
  #--- validations
  validates_presence_of :page
  validates_presence_of :vdeo
  validates_uniqueness_of :page_id, :scope => :vdeo_id
  validates_uniqueness_of :vdeo_id, :scope => :page_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.page
  end
 
  def secondary
     return self.vdeo
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
