class SurveyDocument < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :survey
  belongs_to :document
 
  #--- validations
  validates_presence_of :survey
  validates_presence_of :document
  validates_uniqueness_of :survey_id, :scope => :document_id
  validates_uniqueness_of :document_id, :scope => :survey_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.survey
  end
 
  def secondary
     return self.document
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
