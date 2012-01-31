class User < ActiveRecord::Base
#--------------------------------------------------------------------------------------------------------------------------------

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
    :admin, :developer, :creator, :editor, :destroyer, :releaser,
    :documents,:inventory,:website,:media,:web_social,:web_glossary,:web_faq,:live,:special,:system,
    :name, :title, :description

#--------------------------------------------------------------------------------------------------------------------------------

  include CommonStuff

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def get_roles(options={})
    options[:all]     ||= false
    options[:action]  ||= false
    options[:access]  ||= false
    s  = ''
    if options[:all] || options[:action]
      self.creator    ? s+="<span class='role acc'>CREATOR</span>"          : s+="<span class='role'>CREATOR</span>"
      self.editor     ? s+="<span class='role acc'>EDITOR</span>"           : s+="<span class='role'>EDITOR</span>"
      self.destroyer  ? s+="<span class='role act'>DESTROYER</span>"        : s+="<span class='role'>DESTROYER</span>"
      self.releaser   ? s+="<span class='role act'>RELEASER</span>"         : s+="<span class='role'>REALESER</span>"
    end
    if options[:all] || options[:access]
      self.documents  ? s+="<span class='role acc'>DOC</span>"              : s+="<span class='role'>DOC</span>" 
      self.inventory  ? s+="<span class='role acc'>INV</span>"              : s+="<span class='role'>INV</span>" 
      self.website    ? s+="<span class='role acc'>WEB</span>"              : s+="<span class='role'>WEB</span>" 
      self.web_glossary   ? s+="<span class='role acc'>w.GLOSS</span>"           : s+="<span class='role'>w.GLOSS</span>" 
      self.web_social     ? s+="<span class='role acc'>w.SOCIAL</span>"           : s+="<span class='role'>w.SOCIAL</span>" 
      self.web_faq        ? s+="<span class='role acc'>w.FAQ</span>"           : s+="<span class='role'>w.FAQ</span>" 
      self.media      ? s+="<span class='role acc'>MEDIA</span>"            : s+="<span class='role'>MEDIA</span>" 
      self.live       ? s+="<span class='role acc'>LIVE</span>"             : s+="<span class='role'>LIVE</span>" 
    end
    if options[:all] || options[:special]
      self.special    ? s+="<span class='role spc'>SPECIAL</span>"          : s+="<span class='role'>SPECIAL</span>" 
      self.system     ? s+="<span class='role spc'>SYSTEM</span>"           : s+="<span class='role'>SYSTEM</span>" 
    end
    if options[:all] || options[:system]
      self.developer  ? s+="<span class='role sys'>DEVELOPER</span>"  : s+="<span class='role'>DEVELOPER</span>"
      self.admin      ? s+="<span class='role sys'>ADMIN</span>"          : s+="<span class='role'>ADMIN</span>"
    end
    s = RDisplay::NONE if s.blank?
    return s.html_safe
  end

  def get_system_roles(options={})
    s  = ''
    self.developer  ? s+="<span class='role short sys'>D</span>"    : s+=""
    self.admin      ? s+="<span class='role short sys'>A</span>"    : s+=""
    return s.html_safe
  end

  def get_roles_short(options={})
    options[:all]     ||= false
    options[:special] ||= false
    s  = ''
    self.creator    ? s+="<span class='role short acc'>C</span>"          : s+="<span class='role short'>C</span>"
    self.editor     ? s+="<span class='role short acc'>E</span>"           : s+="<span class='role short'>E</span>"
    self.destroyer  ? s+="<span class='role short act'>D</span>"        : s+="<span class='role short'>D</span>"
    self.releaser   ? s+="<span class='role short act'>R</span>"         : s+="<span class='role short'>R</span>"
    s += '&middot'
    self.documents  ? s+="<span class='role short acc'>D</span>"              : s+="<span class='role short'>D</span>" 
    self.inventory  ? s+="<span class='role short acc'>I</span>"              : s+="<span class='role short'>I</span>" 
    self.website    ? s+="<span class='role short acc'>W</span>"              : s+="<span class='role short'>W</span>" 
    self.web_glossary   ? s+="<span class='role short acc'>G</span>"           : s+="<span class='role short'>G</span>" 
    self.web_social     ? s+="<span class='role short acc'>S</span>"           : s+="<span class='role short'>S</span>" 
    self.web_faq        ? s+="<span class='role short acc'>F</span>"           : s+="<span class='role short'>F</span>" 
    self.media      ? s+="<span class='role short acc'>M</span>"            : s+="<span class='role short'>M</span>" 
    self.live       ? s+="<span class='role short acc'>L</span>"             : s+="<span class='role short'>L</span>" 
    s += '&middot'
    if options[:all] || options[:special]
      self.special    ? s+="<span class='role short spc'>S</span>"          : s+="<span class='role short'>S</span>" 
      self.system     ? s+="<span class='role short spc'>S</span>"           : s+="<span class='role short'>S</span>" 
      s += '&middot'
    end
    self.developer  ? s+="<span class='role short sys'>D</span>"  : s+="<span class='role short'>D</span>"
    self.admin      ? s+="<span class='role short sys'>A</span>"          : s+="<span class='role short'>A</span>"
    return s.html_safe
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def has_roles?(*roles)
    return true if self.admin
    has = true
    roles.each do |role|
      if self.respond_to?(role)
        has &&= self.send(role) == true 
      else
        has = false
      end
    end # do roles
    return has
  end
    
  def has_roles_either?(*roles)
    return true if self.admin
    has = false
    roles.each do |role|
      if self.respond_to?(role)
        has ||= self.send(role) == true 
      end
    end # do roles
    return has
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def can_see?(*items)
    return true if self.admin
    can = true
    items.each{ |item| can &&= AccessMatrix.visible_items_for(self).include?(item) }
    return can
  end
  def can_create?(*items)
    return true if self.admin
    can = true
    items.each{ |item| can &&= AccessMatrix.visible_items_for(self).include?(item) }
    return can && self.creator
  end
  def can_edit?(*items)
    return true if self.admin
    can = true
    items.each{ |item| can &&= AccessMatrix.visible_items_for(self).include?(item) }
    return can && self.editor
  end
  def can_destroy?(*items)
    return true if self.admin
    can = true
    items.each{ |item| can &&= AccessMatrix.visible_items_for(self).include?(item) }
    return can && self.destroyer
  end
  def can_release?(*items)
    return true if self.admin
    can = false
    items.each{ |item| can &&= AccessMatrix.visible_items_for(self).include?(item) }
    return can && self.releaser
  end
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end
