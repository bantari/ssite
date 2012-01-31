class CategoryPromo < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :category
  belongs_to :promo, :class_name => 'Bubble'
 
  #--- validations
  validates_presence_of :category
  validates_presence_of :promo
  validates_uniqueness_of :category_id, :scope => :promo_id
  validates_uniqueness_of :promo_id, :scope => :category_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.category
  end
 
  def secondary
     return self.promo
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
