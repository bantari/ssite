module ApplicationHelper
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def development 
    return Rails.env == 'development'
  end
  def engineering
    return Rails.env == 'engineering'
  end
  def staging 
    return Rails.env == 'staging'
  end

  def application_title
    s = 'StemSite'
    s = '[DEV] site' if development
    s = '[ENG] site' if engineering
    s = '[STG] site' if staging
    return "new #{s}"
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def safe(str)
    return str.html_safe unless str.blank?
    return str
  end
  
  def menu_here(name)
    return 'here' if name.downcase == controller.controller_name
    return ''
  end
  
#--------------------------------------------------------------------------------------------------------------------------------

  def buttons_divider
    return '&middot'.html_safe
  end
  def tabs_divider
    return '&middot'.html_safe
  end

#--------------------------------------------------------------------------------------------------------------------------------
# generate input field descriptions

  def input_msg(name,options={})
    options[:txt]     ||= nil
    options[:no_name] ||= false
    s  = " <span class='input_msg #{name}'>"
    s += "&larr; "
    s += "</b>#{name}<b>" unless options[:no_name]
    s += " - " if options[:txt] && !options[:no_name]
    s += "#{options[:txt]}"  unless options[:txt].blank?
    s += "</span>"
    return s.html_safe
  end
  def optional(options={})
    return input_msg('optional',options)
  end
  def required(options={})
    return input_msg('required',options)
  end
  def necessary(options={})
    return input_msg('necessary',options)
  end
  
  def field_info(txt,options={})
    options[:txt]     = txt
    options[:no_name] = true
    options[:show]    = true if options[:show] == nil
    return input_msg('info',options) if options[:show]
    return ''
  end
  
#--------------------------------------------------------------------------------------------------------------------------------
# generate input field descriptions and styles based on the required_fields and necessary_fields arrays
# required_fields are the fields which cannot be empty for the object to save
# necessary_fields are the fields necessary for object release

  def input_flag(name,required_fields=[],necessary_fields=[])
    return required  if required_fields  && required_fields.size>0  && required_fields.include?(name)
    return necessary if necessary_fields && necessary_fields.size>0 && necessary_fields.include?(name)
    return optional
  end

  def input_class(name,required_fields=[],necessary_fields=[])
    s = ''
    s += ' required'  if required_fields  && required_fields.size>0  && required_fields.include?(name)
    s += ' necessary' if necessary_fields && necessary_fields.size>0 && necessary_fields.include?(name)
    return s
  end
  
  def live_data
    return "<span class='live_data'> &larr; live data !!</span>".html_safe
  end

#--------------------------------------------------------------------------------------------------------------------------------
# returns the class of the row for list table depending on the object's state (active,adjusted,released)

  def row_class_for(obj)
    s = ''
    if obj
      s += ' inactive'   if obj.respond_to?(:active)   && obj.active==false
      s += ' adjusted'   if obj.respond_to?(:adjusted) && obj.adjusted
      s += ' unreleased' if obj.respond_to?(:released) && obj.released==false
    end # if obj
    return s
  end

#--------------------------------------------------------------------------------------------------------------------------------
# generates page titles for common actions

  def page_title_for(obj,act=nil,options={})
    s = ''
    if act == :list
      s = "<h1 class='#{options[:h1_class]}'>List of #{obj.to_s.pluralize}</h1>"
    elsif act == :new
      s = "<h1 class='#{options[:h1_class]}'>Create New #{obj.class_identifier}</h1>"
    else
      s = "<h2 class='#{options[:h2_class]}'>#{obj.h2_title}</h2><h1 class='#{options[:h1_class]}'>#{obj.h1_title}</h1>"
    end
    unless options[:subtitle].blank?
      s += "<h3 class='#{options[:h3_class]}'>#{options[:subtitle]}</h3>"
    end
    return s.html_safe
  end

  def list_title_for(str)
    return "<h1>List of #{str}</h1>".html_safe
  end

  def show_title_for(obj)
    s  = "<h2>#{obj.h2_title}</h2>"
    s += "<h1>#{obj.h1_title}</h1>"
    return s.html_safe
  end

  def new_title_for(obj)
    s  = "<h1>Create New #{obj.class_name}</h1>"
    return s.html_safe
  end

  def edit_title_for(obj,what=nil)
    s  = "<h2>Edit #{obj.h2_title}</h2>"
    s += "<h1>#{obj.h1_title}</h1>"
    #unless what.blank?
    #  s += "<h3>#{what.to_s}</h3>"
    #end
    return s.html_safe
  end
  
  def subtitle(txt,options={})
    s = "<h3 class='#{options[:class]}'>#{txt}</h1>"
    return s.html_safe
  end
  
#--------------------------------------------------------------------------------------------------------------------------------

  def message(str,options={})
    return "<div class='message'>#{str}</div>".html_safe
  end
  def warning(str,options={})
    return "<div class='message warning'><b>Warning:</b> #{str}</div>".html_safe
  end
  def error(str,options={})
    return "<div class='message error'><b>Error:</b> #{str}</div>".html_safe
  end

  def noedit(options)
    s  = "<span class='low'> &larr; non-editable"
    s += " (auto-calculated)" if options[:reason] == :autocalc 
    s += " (event_driven)"    if options[:reason] == :event_driven
    s += "</span>"
    return s
  end
  
  def no_items_found
    return "<span class='no_items_found'>- none -</span>".html_safe
  end
  
#--------------------------------------------------------------------------------------------------------------------------------

  def here_class(options,name,show_when_empty=false)
    options = options[:show] if options && options[:show]
    s = ''
    s = 'here' if options && options[name]
    s = 'here' if options==nil && show_when_empty
    return s
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def get_timeline_event(obj,fld,options={})
    fld_at = "#{fld}_at"
    fld_by = "#{fld}_by"
    return nil unless obj
    return nil unless obj.respond_to?(fld_at)
    
    options[:label] ||= fld.to_s.titleize
    
    s  = ""
    s += "<tr><td class='label'>#{options[:label]}</td><td class='data'>"
    if obj.send(fld_at)
      s += obj.send(fld_at).to_s
      s += " by #{obj.send(fld_by)}" if obj.respond_to?(fld_by)
    else
      s += RDisplay::NONE
    end
    s += "</tr>"
    
    return s.html_safe
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def show_latest_comments_for(obj,count=20)
    comments = Comment.get_last_for(obj,count)
    if comments && comments.size>0
      render :partial=>'/shared/blocks/latest_comments', :locals=>{:items=>comments}
    end
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end
