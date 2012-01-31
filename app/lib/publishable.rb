module Publishable
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def activate
    self.active = !self.active
    self.save
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def get_flags
    arr = []
    if !active
      arr[0] = 'inactive'
    elsif !published
      arr[0] = 'new'
    else
      arr[0] = 'current'
      arr[0] = 'pending' unless self.adjusted
    end
    s = arr.map{|x| "<span class='flag #{x}'>#{x}</span>"}.join(' ')
    return s.html_safe
  end
  
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end