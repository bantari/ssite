class CategoryBanner < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :category
  belongs_to :banner
 
  #--- validations
  validates_presence_of :category
  validates_presence_of :banner
  validates_uniqueness_of :category_id, :scope => :banner_id
  validates_uniqueness_of :banner_id, :scope => :category_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.category
  end
 
  def secondary
     return self.banner
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
