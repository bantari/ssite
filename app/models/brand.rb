class Brand < ActiveRecord::Base
#--------------------------------------------------------------------------------------------------------------------------------

  include CommonStuff

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  #--- validations
  validates_presence_of :name
  
  #--- associations
  belongs_to :parent,   :class_name => 'Brand'
  has_many   :children, :class_name => 'Brand', :foreign_key => :parent_id
  has_many   :products
  
#--------------------------------------------------------------------------------------------------------------------------------

  def reset_trace(options={})
    
    options[:save]      = true if options[:save]      == nil
    options[:recursive] = true if options[:recursive] == nil
    
    self.trace = self.name
    self.trace = "#{self.parent.trace} > #{self.name}" if self.parent
    
    if options[:recursive]
      self.children.each do |child|
        child.reset_trace(options)
      end # do children
    end # if recursive

    self.save! if options[:save]
    return self
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end
