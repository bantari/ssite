class CoursePublication < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :course
  belongs_to :publication
 
  #--- validations
  validates_presence_of :course
  validates_presence_of :publication
  validates_uniqueness_of :course_id, :scope => :publication_id
  validates_uniqueness_of :publication_id, :scope => :course_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.course
  end
 
  def secondary
     return self.publication
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
