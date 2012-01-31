class CourseImage < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :course
  belongs_to :image
 
  #--- validations
  validates_presence_of :course
  validates_presence_of :image
  validates_uniqueness_of :course_id, :scope => :image_id
  validates_uniqueness_of :image_id, :scope => :course_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.course
  end
 
  def secondary
     return self.image
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
