class PagePromo < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :page
  belongs_to :promo, :class_name => 'Bubble'
 
  #--- validations
  validates_presence_of :page
  validates_presence_of :promo
  validates_uniqueness_of :page_id, :scope => :promo_id
  validates_uniqueness_of :promo_id, :scope => :page_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.page
  end
 
  def secondary
     return self.promo
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
