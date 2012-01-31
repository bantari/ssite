class ProductRelation < ActiveRecord::Base
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
 
  #--- associations
  belongs_to :product
  belongs_to :relation, :class_name => 'Product'
 
  #--- validations
  validates_presence_of :product
  validates_presence_of :relation
  validates_uniqueness_of :product_id, :scope => :relation_id
  validates_uniqueness_of :relation_id, :scope => :product_id
 
#-------------------------------------------------------------------------------------
 
  def primary
     return self.product
  end
 
  def secondary
     return self.relation
  end
 
#-------------------------------------------------------------------------------------
#-------------------------------------------------------------------------------------
end
