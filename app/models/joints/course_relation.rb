class CourseRelation < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :course
  belongs_to :relation, :class_name => 'Product'
 
  #--- validations
  validates_presence_of :course
  validates_presence_of :relation
  validates_uniqueness_of :course_id, :scope => :relation_id
  validates_uniqueness_of :relation_id, :scope => :course_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.course
  end
 
  def secondary
     return self.relation
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
