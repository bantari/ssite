class SurveyPromo < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :survey
  belongs_to :promo, :class_name => 'Bubble'
 
  #--- validations
  validates_presence_of :survey
  validates_presence_of :promo
  validates_uniqueness_of :survey_id, :scope => :promo_id
  validates_uniqueness_of :promo_id, :scope => :survey_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.survey
  end
 
  def secondary
     return self.promo
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
