class SurveyBanner < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :survey
  belongs_to :banner
 
  #--- validations
  validates_presence_of :survey
  validates_presence_of :banner
  validates_uniqueness_of :survey_id, :scope => :banner_id
  validates_uniqueness_of :banner_id, :scope => :survey_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.survey
  end
 
  def secondary
     return self.banner
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
