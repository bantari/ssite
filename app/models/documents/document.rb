class Document < ActiveRecord::Base
#--------------------------------------------------------------------------------------------------------------------------------

  include CommonStuff
  include Publishable

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  #--- validations
  validates_presence_of :name
  validates_presence_of :document_type_id
  
  #--- associations
  belongs_to :document_type
  
  has_many :product_documents, :order => 'position ASC', :include => :product
  has_many :products, :through => :product_documents
  accepts_nested_attributes_for :product_documents, :allow_destroy => true, :reject_if => proc {|attributes| attributes["_delete"] == "1"}

  #--- delegations
  delegate :file_path,
    :to => :document_type

  #--- scopes
  scope :for_select, :order => 'name ASC'

#--------------------------------------------------------------------------------------------------------------------------------

  def get_title
    return self.title unless self.title.blank?
    return self.name.titleize
  end

  def get_file_url
    return "#{self.file_path}#{self.file_name}"
  end

  def name_for_selection
    return "#{self.name} (#{self.document_type.name})"
  end
  
  def h2_title
    return self.document_type.title
  end
  
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def necessities
    arr = []
    
    arr << "details > <b>name</b>"            if self.name.blank?
    arr << "details > <b>title</b>"           if self.title.blank?
    arr << "details > <b>file name</b>"       if self.file_name.blank?

    return arr
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end
