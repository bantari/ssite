class ProductPublication < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :product
  belongs_to :publication
 
  #--- validations
  validates_presence_of :product
  validates_presence_of :publication
  validates_uniqueness_of :product_id, :scope => :publication_id
  validates_uniqueness_of :publication_id, :scope => :product_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.product
  end
 
  def secondary
     return self.publication
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
