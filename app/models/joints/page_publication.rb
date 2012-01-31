class PagePublication < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :page
  belongs_to :publication
 
  #--- validations
  validates_presence_of :page
  validates_presence_of :publication
  validates_uniqueness_of :page_id, :scope => :publication_id
  validates_uniqueness_of :publication_id, :scope => :page_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.page
  end
 
  def secondary
     return self.publication
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
