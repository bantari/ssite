class Sku < ActiveRecord::Base
#--------------------------------------------------------------------------------------------------------------------------------

  include CommonStuff
  include Publishable

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  #--- validations
  validates_presence_of :code
  validates_presence_of :price
  
  #--- associations
  belongs_to :course
  belongs_to :product

#--------------------------------------------------------------------------------------------------------------------------------

  def get_details
    s = 'details'
    if self.product
      s = "Size:#{self.size}"
    elsif self.course
    end
    return s.html_safe
  end

  def get_link_to_owner(style=:normal)
    s = 'owner'
    if self.product
      s = "[ P <a href='/products/#{self.product_id}'>#{self.product_id.to_s.rjust(3,'0')}</a> ]"
    elsif self.course
    end
    return s.html_safe
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end
