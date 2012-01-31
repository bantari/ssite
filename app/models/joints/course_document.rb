class CourseDocument < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :course
  belongs_to :document
 
  #--- validations
  validates_presence_of :course
  validates_presence_of :document
  validates_uniqueness_of :course_id, :scope => :document_id
  validates_uniqueness_of :document_id, :scope => :course_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.course
  end
 
  def secondary
     return self.document
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
