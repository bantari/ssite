class PageBanner < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :page
  belongs_to :banner
 
  #--- validations
  validates_presence_of :page
  validates_presence_of :banner
  validates_uniqueness_of :page_id, :scope => :banner_id
  validates_uniqueness_of :banner_id, :scope => :page_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.page
  end
 
  def secondary
     return self.banner
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
