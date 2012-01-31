class SurveyImage < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :survey
  belongs_to :image
 
  #--- validations
  validates_presence_of :survey
  validates_presence_of :image
  validates_uniqueness_of :survey_id, :scope => :image_id
  validates_uniqueness_of :image_id, :scope => :survey_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.survey
  end
 
  def secondary
     return self.image
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
