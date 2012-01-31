class ProductDocument < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :product
  belongs_to :document
 
  #--- validations
  validates_presence_of :product
  validates_presence_of :document
  validates_uniqueness_of :product_id, :scope => :document_id
  validates_uniqueness_of :document_id, :scope => :product_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.product
  end
 
  def secondary
     return self.document
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
