class CourseReference < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :course
  belongs_to :reference, :class_name => 'Publication'
 
  #--- validations
  validates_presence_of :course
  validates_presence_of :reference
  validates_uniqueness_of :course_id, :scope => :reference_id
  validates_uniqueness_of :reference_id, :scope => :course_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.course
  end
 
  def secondary
     return self.reference
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
