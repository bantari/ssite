class PageDocument < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :page
  belongs_to :document
 
  #--- validations
  validates_presence_of :page
  validates_presence_of :document
  validates_uniqueness_of :page_id, :scope => :document_id
  validates_uniqueness_of :document_id, :scope => :page_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.page
  end
 
  def secondary
     return self.document
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
