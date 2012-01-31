class SurveyMenu < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :survey
  belongs_to :menu, :class_name => 'Bubble'
 
  #--- validations
  validates_presence_of :survey
  validates_presence_of :menu
  validates_uniqueness_of :survey_id, :scope => :menu_id
  validates_uniqueness_of :menu_id, :scope => :survey_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.survey
  end
 
  def secondary
     return self.menu
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
