# Manages filtering conditions for displaying item lists
# Sets condition for the SQL search
class RDisplay
#==============================================================================================

  NONE  = "<span class='low'>&mdash;</span>".html_safe
  ZERO  = '&mdash;'.html_safe
  MINUS = '<strong>-</strong> '.html_safe
  NA    = 'n / a'
  
  def self.r_safe(str)
    return str           if str.blank?
    return str.html_safe if str.class.name=='String'
    return str
  end
    

#==============================================================================================
#==============================================================================================
# OBJECT

  def self.obj(o,method=:to_s,options={})
    options[:empty] ||= NONE 
    s = options[:empty]
    if o
      s = o.to_s
      s = o.send(method.to_s) if o.respond_to?(method)
    end
    return r_safe s
  end

  def self.link_to_obj(o,method=:to_s,options={})
    options[:disabled] ||= false 
    options[:empty]    ||= NONE 
    options[:poly]     ||= false 
    options[:title]    ||= nil
    options[:class]    ||= nil
    s = options[:empty]
    if o
      txt = o.to_s
      txt = o.send(method.to_s) if o.respond_to?(method)
      s  = "<a href='/#{o.class.name.tableize}/#{o.id}'"
      s += " title='#{options[:title]}'" if options[:title] 
      s += " class='#{options[:class]}'" if options[:class]
      s += ">#{txt}</a>"
      s = txt if options[:disabled]
    end
    
    return r_safe s
  end

  def self.id_link(item,options={})
    options[:default_text] ||= '[new]'
    options[:link_text]    ||= RDisplay.id_str(item,options)
    options[:disabled]     ||= false
    options[:class]        ||= ''
    return NONE unless item
    return options[:link_text] if options[:disabled]
    return link_to(options[:link_text],"/#{item.class.name.tableize}/#{item.id}",:class=>options[:class])
  end

  def self.link_to_owner(o,method=:to_s,options={})
    options[:disabled]     ||= false 
    options[:empty]        ||= NONE 
    options[:title]        ||= ''
    options[:link_prefix]  ||= ''
    options[:link_postfix] ||= ''
    options[:separator]    ||= ' &rarr; '
    s = options[:empty]
    if o
      txt = o.id.to_s
      txt = o.send(method.to_s) if o.respond_to?(method)
      s = "#{o.class.name}#{options[:separator]}#{options[:link_prefix]}<a href='/#{o.class.name.tableize}/#{o.id}' title='#{options[:title]}'>#{txt}</a>#{options[:link_postfix]}"
      s = "#{o.class.name}#{options[:separator]}#{options[:link_prefix]}#{txt}#{options[:link_postfix]}" if options[:disabled]
    end
    return r_safe s
    if item
      s = "#{item.class.to_s.titleize} (#{link_to_object(item,field)})"
    end
    return r_safe s
  end
  
  def self.boolean_link(value,name,options={})
    options[:yes] = 'yes'
    options[:no]  = 'no'
    current = value ? options[:yes] : options[:no]
    return current if options[:disabled]
    future = value ? options[:no] : options[:yes]
    s  = current
    s += " (#{link_to(future,"?#{name}=#{future}")})"
    return r_safe s
  end

#==============================================================================================
# ARRAY

  def self.arr(a, method=:to_s, options={})
    options[:empty]     ||= NONE 
    options[:delimiter] ||= ', ' 
    options[:prefix]    ||= ''
    options[:postix]    ||= ''
    s = options[:empty]
    if a && a.to_a.length>0
      m = :to_s
      m = method if a[0].respond_to?(method)
      s = a.map{|x| "#{options[:prefix]}#{x.send(m)}#{options[:postfix]}"}.join(options[:delimiter])
    end
    return r_safe s
  end

  def self.arr_of_links(a, method=:to_s, options={})
    options[:empty]     ||= NONE 
    options[:delimiter] ||= ', ' 
    options[:prefix]    ||= ''
    options[:postix]    ||= ''
    s = options[:empty]
    if a && a.to_a.length>0
      aa = []
      a.each do |obj|
        m = :to_s
        m = method if a[0].respond_to?(method)
        aa << "#{options[:prefix]}#{RDisplay.link_to_obj(obj,m)}#{options[:postfix]}" 
      end
      s = aa.join(options[:delimiter])
    end
    return r_safe s
  end

  def self.arr_of_links_to_owners(a, method=:to_s, options={})
    options[:empty]     ||= NONE 
    options[:delimiter] ||= '<br/>' 
    options[:prefix]    ||= ''
    options[:postix]    ||= ''
    s = options[:empty]
    if a && a.to_a.length>0
      aa = []
      a.each do |obj|
        m = :to_s
        m = method if a[0].respond_to?(method)
        aa << "#{options[:prefix]}#{RDisplay.link_to_owner(obj,m)}#{options[:postfix]}" 
      end
      s = aa.join(options[:delimiter])
    end
    return r_safe s
  end

#==============================================================================================
# STRING

  def self.str(s,options={})
    options[:empty]   ||= NONE 
    options[:width]   ||= 0
    options[:html_safe] = true if options[:html_safe] == nil
    ss = options[:empty]
    ss = s if s && s.to_s.length>0
    if options[:width]>0 && s.to_s.length>options[:width]
      ss = "#{s.to_s[0..options[:width]-1]} ..."
    end
    return r_safe ss if options[:html_safe]
    return ss
  end
  
  def self.str_h(s,options={})
    s = s.gsub('<','&lt;').gsub('>','&gt;') if s
    options[:html_safe] = false
    return RDisplay.str(s,options)
  end

  def self.txt(s,options={})
    options[:fieldset]       = true if options[:fieldset] == nil
    options[:legend_align] ||= "right"
    options[:html_safe]      = true if options[:html_safe] == nil
    ss = str(s,options)
    ss = "<fieldset><legend align='#{options[:legend_align]}'>Text</legend>#{ss}</fieldset" if !s.blank? && options[:fieldset]
    return r_safe ss if options[:html_safe]
    return ss
  end
  
  def self.id_str(item,options={})
    options[:default_text] ||= NONE
    options[:width]        ||= 6
    options[:padding]      ||= '0'
    s = options[:default_text]
    s = item.id.to_s.rjust(options[:width],options[:padding]) if item && item.id
    return r_safe s
  end
  
  def self.block(s,options={})
    options[:block_id]    ||= ''
    options[:block_class] ||= ''
    options[:html_safe]     = true if options[:html_safe] == nil
    s = RDisplay.str(s,options)
    s = "<div id='#{options[:block_id]}'class='#{options[:block_class]}'>#{s}</div>"
    return r_safe s if options[:html_safe]
    return s
  end
  
  def self.code(s,options={})
    options[:block_name]  ||= 'pre'
    options[:block_id]    ||= nil
    options[:block_class] ||= nil
    options[:block_style] ||= nil
    ss = RDisplay.str(s,options)
    s  = "<#{options[:block_name]}"
    s += " id='#{options[:block_id]}'"    if options[:block_id]
    s += " class='#{options[:block_class]}'" if options[:block_class]
    s += " style='#{options[:block_style]}'" if options[:block_style]
    s += ">#{ss}</#{options[:block_name]}>"
    return r_safe s
  end
  
#====================================================================================== amount
# MONEY

  # displays amount in dollars
  def self.dollars(d,options={}) 
    options[:empty]     ||= NONE
    options[:prefix]    ||= '$'
    options[:thousands] ||= ','
    options[:decimal]   ||= '.'
    options[:postfix]   ||= ''
    options[:style]     ||= nil
    options[:zero_none] ||= false
    options[:zero_class]||= 'zero'
    options[:parens]    ||= false
    options[:minus]     ||= MINUS
    if d && d==0 && options[:zero_none]
      s = options[:empty] 
      s = "<span class='options[:zero_class]'>#{s}</span>" if options[:zero_class]
      return r_safe s
    end
    s = options[:empty]
    s = "#{options[:prefix]}#{( "%.2f" % d.to_f.abs ).gsub( /(\d)(?=(?:\d{3})+(?:$|\.))/, "\\1#{options[:thousands]}" )}#{options[:postfix]}" if d
    s = "<span class='#{options[:style]}'>#{s}</span>" if options[:style]
    if d && d.to_f<0
      if options[:parens]
        s = "(#{s})" # parentheses signify negative amount
      else
        s = "#{options[:minus]}#{s}"
      end
    end
    return r_safe s
  end
  
  def self.cents(c,options={})
    s = RDisplay.dollars(c.to_f/100.00,options)
    return r_safe s
  end
  
  def self.dollars_with_style(d,options={}) 
    options[:zero_class]      ||= 'zero'
    options[:positive_class]  ||= 'positive'
    options[:negative_class]  ||= 'negative'
    s = RDisplay.dollars(d,options)
    ss = "<span class='#{options[:zero_class]}'>#{s}</span>"
    ss = "<span class='#{options[:positive_class]}'>#{s}</span>" if d && d>0
    ss = "<span class='#{options[:negative_class]}'>#{s}</span>" if d && d<0
    return r_safe ss
  end
  
#==============================================================================================

  def self.percent(p,options={})
    options[:empty]     ||= NONE
    options[:prefix]    ||= ''
    options[:postfix]   ||= '%'
    options[:style]     ||= nil
    options[:zero_none] ||= false
    return options[:empty] unless p
    return options[:empty] if p==0 && options[:zero_none]
    return r_safe "#{options[:prefix]}#{p}#{options[:postfix]}"
  end

#==============================================================================================
# DATE

  MONTH_SHORT = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
  MONTH_LONG  = %w[January February March April May June July August September October November December]

  def self.date(d,options={})
    return NONE unless d
    s = NONE
    if options[:format] == :pritty
      s = "#{MONTH_SHORT[d.mon()-1]} #{d.mday()}, #{d.year()}"
    elsif options[:format] == :pritty_full
      s = " #{d.mday()} #{MONTH_LONG[d.mon()-1]} #{d.year()}"
    elsif options[:format] == :sortable_simple
      s = "#{sprintf("%04d%02d%02d",d.year(),d.mon(),d.mday())}"
    else
      s = "#{sprintf("%02d/%02d/%04d",d.mon(),d.mday(),d.year())}"
    end
    return r_safe s
  end

#==============================================================================================
# BOOLEAN

  def self.yn(value,options={})
    options[:yes] ||= 'yes'
    options[:no]  ||= 'no'
    s = options[:no]
    s = options[:yes] if value != false && value != nil
    return r_safe s
  end

  def self.yn_with_style(value,options={})
    options[:main_class]||= 'boolean_flag'
    options[:yes_class] ||= 'yes_flag'
    options[:no_class]  ||= 'no_flag'
    options[:yes]       ||= "<span class='#{options[:main_class]} #{options[:yes_class]}'>YES</span>"
    options[:no]        ||= "<span class='#{options[:main_class]} #{options[:no_class]}'>NO</span>"
    return RDisplay.yn(value,options)
  end

  def self.yn_with_style_y(value,options={})
    options[:yes_class]  ||= 'boolean_flag yes_flag_strong'
    return RDisplay.yn_with_style(value,options)
  end
  def self.yn_with_style_n(value,options={})
    options[:no_class]   ||= 'boolean_flag no_flag_strong'
    return RDisplay.yn_with_style(value,options)
  end
  def self.yn_with_style_yn(value,options={})
    options[:no_class]   ||= 'boolean_flag no_flag_strong'
    options[:yes_class]  ||= 'boolean_flag yes_flag_strong'
    return RDisplay.yn_with_style(value,options)
  end
  def self.yn_with_style_ya(value,options={})
    options[:yes_class]   ||= 'boolean_flag yes_flag_alert'
    return RDisplay.yn_with_style(value,options)
  end
  def self.yn_with_style_na(value,options={})
    options[:no_class]   ||= 'boolean_flag no_flag_alert'
    return RDisplay.yn_with_style(value,options)
  end


#==============================================================================================
# COUNT

  def self.count(value)
    s = ZERO
    s = value.to_i.to_s if value && value.to_i!=0 
    return r_safe s
  end

  def self.int(value)
    s = '0'
    s = value.to_i.to_s if value 
    return r_safe s
  end

#==============================================================================================
# FANCY

  def self.with_style(obj,method=:to_s,options={})
    options[:empty] ||= NONE
    return options[:empty] unless obj
    m = :to_s
    m = method if obj.respond_to?(method)
    styl = ''
    styl = obj.style if obj.respond_to?(:style)
    return r_safe "<span class='#{styl}'>#{obj.send(m)}</span>"
  end

#==============================================================================================
# HELP

  def self.help_block(help_text=nil, options={})
    help_text ||= "There is no help info on this subject."
    options[:help_id]    ||= "#{label.downcase.gsub(' ','_')}_help"
    options[:help_class] ||= "help_block"
    options[:title_icon_class] ||= 'title_icon'
    options[:title_icon] ||= '&uarr; '
    options[:title]      ||= "<h5><span class='#{options[:title_icon_class]}'>#{options[:title_icon]}</span>#{label.titleize} Help:</h5>"
    options[:show_title]   = true if options[:show_title] == nil
    options[:help_label] ||= 'help &rarr; '
    options[:show_label] ||= '+'
    options[:hide_label] ||= '-'
    options[:divider]    ||= '|'
    options[:link_class] ||= 'help_links'
    show_link = "<a href='#' onclick=\"showElement('#{options[:help_id]}')\">#{options[:show_label]}</a>"
    hide_link = "<a href='#' onclick=\"hideElement('#{options[:help_id]}')\">#{options[:hide_label]}</a>"
    s  = "<div class='help_links'>#{options[:help_label]}[#{show_link}|#{hide_link}]</div>"
    s += "#{data}"
    s += "<div id='#{options[:help_id]}' class='noshow'><div class='#{options[:help_class]}'>"
    s += options[:title] if options[:show_title]
    s += "#{options[:help_text]}"
    s += "</div></div>"
    return r_safe s
  end

#==============================================================================================
# TABLE

  def self.label_td(label,options={})
    options[:label_class]   ||= 'label'
    options[:label_prefix]  ||= ''
    options[:label_postfix] ||= ''
    options[:label_arrow]   ||= ' &raquo; '
    s  = "<td class='#{options[:label_class]}'>"
    s += options[:label_prefix] if options[:label_prefix] && options[:label_prefix].length>0
    s += label
    s += options[:label_postfix] if options[:label_postfix] && options[:label_postfix].length>0
    s += options[:label_arrow] if options[:label_arrow] && options[:label_arrow].length>0
    s += "</td>"
    return r_safe s
  end

  def self.row(label, data, options={})
    options[:row_class]     ||= ''
    options[:data_class]    ||= 'data'
    options[:colspan]       ||= 1
    options[:data_prefix]   ||= ''
    options[:data_postfix]  ||= ''
    s  = "<tr class='#{options[:row_class]}'>"
    s += label_td(label,options)
    s += "<td class='#{options[:data_class]}' colspan='#{options[:colspan]}'>"
    s += options[:data_prefix] if options[:data_prefix] && options[:data_prefix].length>0
    s += "#{data}"
    s += options[:data_postfix] if options[:data_postfix] && options[:data_postfix].length>0
    s += "</td></tr>"
    return r_safe s
  end

  def self.data_row(item,field,options={})
    field                ||= :to_s
    options[:label]      ||= field.to_s.titleize
    options[:data_class] ||= "data #{field.to_s}"
    if item.respond_to?(field)
      data = str("#{item.send(field)}")
    else
      data = str("[#{item.send(:to_s)}](#{field})",options)
    end
    row(options[:label],data,options)
  end
  
  def self.txt_row(item,field,options={})
    field                ||= :to_s
    options[:label]      ||= field.to_s.titleize
    options[:data_class] ||= "data #{field.to_s}"
    if item.respond_to?(field)
      data = txt("#{item.send(field)}")
    else
      data = txt("[#{item.send(:to_s)}](#{field})",options)
    end
    row(options[:label],data,options)
  end
  
  def self.styled_row(item,field,options={})
    field                  ||= :to_s
    options[:label]        ||= field.to_s.titleize
    options[:data_class]   ||= "data styled #{field.to_s}"
    name  = field.to_s.titleize
    if item.respond_to?(field)
      data = with_style(item.send(field),field,options)
    else
      data = str("[#{item.send(:to_s)}](#{field})",options)
    end
    row(options[:label],data,options)
  end
  
  def self.yn_row(item,field,options={})
    field                ||= :to_s
    options[:display]    ||= :normal
    options[:label]      ||= field.to_s.titleize
    options[:data_class] ||= "data yn #{field.to_s}"
    options[:info]       ||= ''
    name  = field.to_s.titleize
    if item.respond_to?(field)
      case options[:display]
        when :y_strong then data = yn_with_style_y(item.send(field),options)
        when :n_strong then data = yn_with_style_n(item.send(field),options)
        when :y_alert  then data = yn_with_style_ya(item.send(field),options)
        when :n_alert  then data = yn_with_style_na(item.send(field),options)
        else
          data = yn_with_style(item.send(field),options)
        end
    else
      data = str("[#{item.send(:to_s)}](#{field})",options)
    end
    data = data+options[:info] unless options[:info].blank?
    row(options[:label],data,options)
  end
  
  def self.date_row(item,field,options={})
    field                ||= :to_s
    options[:label]      ||= field.to_s.titleize
    options[:data_class] ||= "data date #{field.to_s}"
    name  = field.to_s.titleize
    if item.respond_to?(field)
      data = date(item.send(field),options)
    else
      data = str("[#{item.send(:to_s)}](#{field})",options)
    end
    row(options[:label],data,options)
  end
  
  def self.id_row(item,options={})
    options[:data_class] ||= 'data dark'
    row('ID',id_link(item,options),options)
  end
  
  def self.row_for_selection_with_none(label, item, field, collection, options={})
    options[:row_class]     ||= ''
    options[:data_class]    ||= 'data'
    options[:colspan]       ||= 1
    options[:data_prefix]   ||= ''
    options[:data_postfix]  ||= ''
    s  = "<tr class='#{options[:row_class]}'>"
    s += label_td(label,options)
    s += "<td class='#{options[:data_class]}' colspan='#{options[:colspan]}'>"
    s += options[:data_prefix] if options[:data_prefix] && options[:data_prefix].length>0
    s += selection_with_none(item,field,collection,options)
    s += options[:data_postfix] if options[:data_postfix] && options[:data_postfix].length>0
    s += "</td></tr>"
    return r_safe s
  end
  
  def self.row_with_help(label, data, options={})
    options[:row_class]  ||= ''
    options[:help_id]    ||= "#{label.downcase.gsub(' ','_')}_help"
    options[:help_class] ||= "help_block"
    options[:title_icon_class] ||= 'title_icon'
    options[:title_icon] ||= '&uarr; '
    options[:title]      ||= "<h5><span class='#{options[:title_icon_class]}'>#{options[:title_icon]}</span>#{label.titleize} Help:</h5>"
    options[:show_title]   = true if options[:show_title] == nil
    options[:help_text]  ||= "There is no help info on this subject."
    options[:colspan]    ||= 1
    options[:help_label] ||= 'help &rarr; '
    options[:show_label] ||= '+'
    options[:hide_label] ||= '-'
    options[:divider]    ||= '|'
    options[:link_class] ||= 'help_links'
    show_link = "<a href='#' onclick=\"showElement('#{options[:help_id]}')\">#{options[:show_label]}</a>"
    hide_link = "<a href='#' onclick=\"hideElement('#{options[:help_id]}')\">#{options[:hide_label]}</a>"
    s = "<tr class='#{options[:row_class]}'>#{label_td(label,options)}<td class='data' colspan='#{options[:colspan]}'>"
    s += "<div class='help_links'>#{options[:help_label]}[#{show_link}|#{hide_link}]</div>"
    s += "#{data}"
    s += "<div id='#{options[:help_id]}' class='noshow'><div class='#{options[:help_class]}'>"
    s += options[:title] if options[:show_title]
    s += "#{options[:help_text]}"
    s += "</div></div></td></tr>"
    return r_safe s
  end

#==============================================================================================
# LINKS

  def self.link_to(label,url,options={})
    options[:title] ||= nil
    options[:class] ||= nil
    options[:style] ||= nil
    s = "<a href=\"#{url}\"'"
    s += " title=\"#{options[:title]}\"" if options[:title]
    s += " class=\"#{options[:class]}\"" if options[:class]
    s += " style=\"#{options[:style]}\"" if options[:style]
    s += ">#{label}</a>"
    return r_safe s
  end

  def self.link_to_function(label,function,options={})
    options[:title]  ||= nil
    options[:class]  ||= nil
    options[:style]  ||= nil
    options[:target] ||= nil
    s = "<a href='#'"
    s += " title=\"#{options[:title]}\"" if options[:title]
    s += " class=\"#{options[:class]}\"" if options[:class]
    s += " style=\"#{options[:style]}\"" if options[:style]
    s += " target=\"#{options[:target]}\"" if options[:target]
    s += " onclick=\"#{function}\">#{label}</a>"
    return r_safe s
  end

  def self.go_back_link(options={})
    options[:label] ||= 'Back'
    options[:title] ||= 'Go Back to the Last Page'
    options[:class] ||= nil
    options[:style] ||= nil
    return link_to_function(options[:label],"history.go(-1)",options)
  end

#=======================================================================================
# SPECIALIZED LINKS

  def self.www_link(www,options={})
    options[:label]  ||= www
    options[:target] ||= '_blank' 
    return link_to(options[:label],www,options)
  end

  def self.email_link(email,options={})
    options[:label]  ||= email
    options[:target] ||= '_blank' 
    return link_to(options[:label],email,options)
  end

#=======================================================================================
# FORMS

  class FormOptionsHelper
    include ActionView::Helpers::FormOptionsHelper
  end

  def self.selection_with_none(item, field, collection, options={})
    s = ''
    return s unless item && field && collection
    helper = FormOptionsHelper.new
    options[:obj_name]   ||= item.class.name.tableize.singularize
    options[:fld_name]   ||= field.to_s
    options[:none]       ||= 'none'
    options[:value_fcn]  ||= :id
    options[:name_fcn]   ||= :name_for_selection
    options[:value_none] ||= nil
    current_value = item.send(options[:fld_name].to_sym)
    
    s += "<select name='#{options[:obj_name]}[#{options[:fld_name]}]' id='#{options[:obj_name]}_#{options[:fld_name]}'>"
    s += "<option value='#{nil}' #{ current_value == options[:value_none] ? 'selected=\'selected\'' : ''}>-#{options[:none]}-</option>"
    s += helper.options_from_collection_for_select(collection, options[:value_fcn], options[:name_fcn], current_value)

    return s
  end

  def self.submit_form_link(form_id,options={})
    options[:label] ||= 'Save'
    options[:title] ||= 'Submit this form and save the data'
    options[:class] ||= 'form_submit'
    return link_to_function(options[:label],"document.getElementById('#{form_id}').submit();",options)
  end

  def self.cancel_form_link(url=nil,options={})
    options[:label] ||= 'Cancel'
    options[:title] ||= 'Cancel this form'
    options[:class] ||= 'form_cancel'
    s = go_back_link(options)
    s = link_to(options[:label],url,options) if url
    return s
  end

#=======================================================================================
#=======================================================================================
end