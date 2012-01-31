class SurveyPublication < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :survey
  belongs_to :publication
 
  #--- validations
  validates_presence_of :survey
  validates_presence_of :publication
  validates_uniqueness_of :survey_id, :scope => :publication_id
  validates_uniqueness_of :publication_id, :scope => :survey_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.survey
  end
 
  def secondary
     return self.publication
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
