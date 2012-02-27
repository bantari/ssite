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

  def get_size
    return self.size.blank? ? '<i>?size?</i>' : self.size
  end
  def get_package
    return self.package.blank? ? '<i>?package?</i>' : self.package
  end
  def get_location
    return self.location.blank? ? '<i>?location?</i>' : self.location
  end


#--------------------------------------------------------------------------------------------------------------------------------

  def get_details
    s = 'details'
    if self.product
      s = "[P] Size: #{self.get_size}, Package: #{self.get_package}"
    elsif self.course
      s = "[C] #{RDisplay.str(self.get_location)}: #{RDisplay.date(self.start_date)} - #{RDisplay.date(self.end_date)} [Enrolled: #{self.enrolled || 0}/#{self.capacity || 0}]"
    end
    return s.html_safe
  end

  def get_link_to_owner(style=:normal)
    s = 'owner'
    if self.product
      s = "<a href='/products/#{self.product_id}' class='low'>#{self.product.code}</a>"
    elsif self.course
      s = "<a href='/courses/#{self.course_id}' class='low'>#{self.course.code}</a>"
    end
    return s.html_safe
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end
