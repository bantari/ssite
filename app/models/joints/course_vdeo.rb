class CourseVdeo < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :course
  belongs_to :vdeo
 
  #--- validations
  validates_presence_of :course
  validates_presence_of :vdeo
  validates_uniqueness_of :course_id, :scope => :vdeo_id
  validates_uniqueness_of :vdeo_id, :scope => :course_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.course
  end
 
  def secondary
     return self.vdeo
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
