class CourseComponent < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :course
  belongs_to :component, :class_name => 'Product'
 
  #--- validations
  validates_presence_of :course
  validates_presence_of :component
  validates_uniqueness_of :course_id, :scope => :component_id
  validates_uniqueness_of :component_id, :scope => :course_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.course
  end
 
  def secondary
     return self.component
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
