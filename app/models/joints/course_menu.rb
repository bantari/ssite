class CourseMenu < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :course
  belongs_to :menu, :class_name => 'Bubble'
 
  #--- validations
  validates_presence_of :course
  validates_presence_of :menu
  validates_uniqueness_of :course_id, :scope => :menu_id
  validates_uniqueness_of :menu_id, :scope => :course_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.course
  end
 
  def secondary
     return self.menu
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
