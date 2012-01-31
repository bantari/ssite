class SurveyStyle < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :survey
  belongs_to :style
 
  #--- validations
  validates_presence_of :survey
  validates_presence_of :style
  validates_uniqueness_of :survey_id, :scope => :style_id
  validates_uniqueness_of :style_id, :scope => :survey_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.survey
  end
 
  def secondary
     return self.style
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
