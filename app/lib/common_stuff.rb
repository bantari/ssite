module CommonStuff
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def class_name
    return self.class.name.titleize
  end
  def table_name
    return self.class.name.tableize
  end
  
  def class_identifier
    return "#{self.class.name.titleize} #{self.id}" if self.id
    return "New #{self.class.name.titleize}"
  end
  def name_identifier
    s = self.code  if self.respond_to?(:code)  && !self.code.blank?
    s = self.name  if s.blank? && self.respond_to?(:name)  && !self.name.blank?
    s = self.title if s.blank? && self.respond_to?(:title) && !self.title.blank?
    s = self.class_identifier  if s.blank? 
    return s.html_safe unless s.blank?
    return s
  end

  def full_identifier
    return self.name_identifier
  end
  def name_for_selection
    return self.full_identifier
  end
  
  def to_s
    name_for_selection
  end

  def h1_title
    self.name_identifier
  end
  def h2_title
    self.class_identifier
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def activate
    self.active = !self.active
    self.save
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def log_event(usr,act,dscr='',options={})
    return unless self.respond_to?(:history)
    event  = "- [#{Time.now}] - [#{usr ? usr.id : '?'}] - #{act}"
    event += " - #{dscr}" unless dscr.blank?
    self.history = "#{event}<br/>#{self.history || ''}"
    self.save!
    ActionEvent.generate(usr,self,act,dscr)
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end