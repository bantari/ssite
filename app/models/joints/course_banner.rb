class CourseBanner < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :course
  belongs_to :banner
 
  #--- validations
  validates_presence_of :course
  validates_presence_of :banner
  validates_uniqueness_of :course_id, :scope => :banner_id
  validates_uniqueness_of :banner_id, :scope => :course_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.course
  end
 
  def secondary
     return self.banner
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
