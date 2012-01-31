class SurveyVdeo < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :survey
  belongs_to :vdeo
 
  #--- validations
  validates_presence_of :survey
  validates_presence_of :vdeo
  #validates_uniqueness_of :survey_id, :scope => :vdeo_id
  #validates_uniqueness_of :vdeo_id, :scope => :survey_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.survey
  end
 
  def secondary
     return self.vdeo
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
