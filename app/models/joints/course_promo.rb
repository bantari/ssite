class CoursePromo < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :course
  belongs_to :promo, :class_name => 'Bubble'
 
  #--- validations
  validates_presence_of :course
  validates_presence_of :promo
  validates_uniqueness_of :course_id, :scope => :promo_id
  validates_uniqueness_of :promo_id, :scope => :course_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.course
  end
 
  def secondary
     return self.promo
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
