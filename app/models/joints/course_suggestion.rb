class CourseSuggestion < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :course
  belongs_to :suggestion, :class_name => 'Product'
 
  #--- validations
  validates_presence_of :course
  validates_presence_of :suggestion
  validates_uniqueness_of :course_id, :scope => :suggestion_id
  validates_uniqueness_of :suggestion_id, :scope => :course_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.course
  end
 
  def secondary
     return self.suggestion
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
