class Product < ActiveRecord::Base
#--------------------------------------------------------------------------------------------------------------------------------

  include CommonStuff
  include Publishable

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  #--- validations
  validates_presence_of   :code
  validates_uniqueness_of :code
  validates_presence_of   :name
  validates_uniqueness_of :name
  
  #--- associations
  belongs_to :brand
  belongs_to :category
  has_many   :categories
  
  has_many :skus
  accepts_nested_attributes_for :skus, :allow_destroy => true, 
    :reject_if => proc {|attributes| attributes["_delete"] == "1"}
  def active_skus
    arr = []
    self.skus.each { |sku| arr << sku if sku.active }
    return arr
  end
  def publishable_skus
    arr = []
    self.skus.each { |sku| arr << sku if sku.active && sku.published && !sku.adjusted}
    return arr
  end
  
  has_many :product_relations, :order => 'position ASC', :include => :relation
  has_many :relations, :through => :product_relations, :class_name => 'Product'
  accepts_nested_attributes_for :product_relations, :allow_destroy => true, 
    :reject_if => proc {|attributes| attributes["_delete"] == "1"}

  has_many :product_components, :order => 'position ASC', :include => :component
  has_many :components, :through => :product_components, :class_name => 'Product'
  accepts_nested_attributes_for :product_components, :allow_destroy => true, 
    :reject_if => proc {|attributes| attributes["_delete"] == "1"}
  
  has_many :product_suggestions, :order => 'position ASC', :include => :suggestion
  has_many :suggestions, :through => :product_suggestions, :class_name => 'Product'
  accepts_nested_attributes_for :product_suggestions, :allow_destroy => true, 
    :reject_if => proc {|attributes| attributes["_delete"] == "1"}

  #--- additional accessors
  attr_accessor :editorial_comment
  
  #--- scope
  scope :for_select, :order => 'code ASC'

  #--- callbacks
  before_save :before_save_tasks
  
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def full_identifier
    return "#{self.code} -- #{self.name}"
  end
  
  def h1_title
    return self.name
  end
  def h2_title
    return self.code
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
  def update_auto_keywords
    arr = []
    arr << self.code
    arr << self.code.gsub('-','')
    self.skus.each do |sku|
      arr << sku.code
      arr << sku.code.gsub('-','')
    end
    self.a_keywords = arr.join(', ')
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def before_save_tasks
    update_auto_keywords
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def necessities
    arr = []
    
    arr << "details > <b>base sku</b>"            if self.code.blank?
    arr << "details > <b>name</b>"                if self.name.blank?
    
    arr << "search > meta > <b>keywords</b>"      if self.m_keywords.blank?
    arr << "search > meta > <b>description</b>"   if self.m_keywords.blank?

    arr << "<b>overview</b>"                      if self.overview.blank?
    arr << "<b>specifications</b>"                if self.specifications.blank?
    
    arr << "need at least one <b>available SKU</b> (i.e. flagged as CURRENT)"  if self.publishable_skus.size == 0

    return arr
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end
