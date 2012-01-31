class CourseStyle < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :course
  belongs_to :style
 
  #--- validations
  validates_presence_of :course
  validates_presence_of :style
  validates_uniqueness_of :course_id, :scope => :style_id
  validates_uniqueness_of :style_id, :scope => :course_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.course
  end
 
  def secondary
     return self.style
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
