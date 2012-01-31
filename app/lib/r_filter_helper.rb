module RFilterHelper
#============================================================================================================================

  def self.r_safe(str)
    return str           if str.blank?
    return str.html_safe if str.is_a?(String)
    return str
  end

#============================================================================================================================

  def self.paginate_fields_button(filter)
    s = "<input type='hidden' name='filter[view_all]' id='filter_view_all' value='#{filter.paginate ? 'no' : 'yes'}' />"
    s += simple_buttons( filter.paginate ? RFilterHelper.js_link("document.getElementById('filter_view_all').value='yes';document.getElementById('filters').submit();",:label=>"View All") : RFilterHelper.js_link("document.getElementById('filter_view_all').value='no';document.getElementById('filters').submit();",:label=>"Paginate") )
    return r_safe s
  end

  def self.paginate_fields(filter)
    s = "View All? <input type='checkbox' name='filter[do_viewall]' value='yes' #{filter.paginate ? '' : 'checked'} class='checkbox' />&nbsp;"
    s += "<input type='hidden' value='paginate' name='filter[paginate]'>"
    return r_safe s
  end

  def self.viewall_fields(filter)
    s = "Paginate? <input type='checkbox' name='filter[do_paginate]' value='yes' #{filter.paginate ? 'checked' : ''} class='checkbox' />&nbsp;"
    s += "<input type='hidden' value='viewall' name='filter[viewall]'>"
    return r_safe s
  end

  def self.perpage_field(filter,options={})
    options[:hidden] = true if options[:hidden] == nil
    options[:select] = {}
    if options[:hidden]
      s = "<input type='hidden' value='#{filter.perpage}' name='filter[perpage]' id='filters_perpage' >"
    else
      s = "<input type='text' value='#{filter.perpage}' name='filter[perpage]' id='filters_perpage' >"
    end
    return r_safe s
  end

  def self.perpage_link(filter,number,options={})
    options[:title]   ||= "View #{number} items per page"
    options[:form_id] ||= 'filters'
    options[:style]   ||= number.to_i==filter.perpage.to_i ? 'here' : ''
    options[:label]   ||= number.to_s
    s = "<a title='#{options[:title]}' onclick=\"document.getElementById('filters_perpage').value='#{number}';document.getElementById('#{options[:form_id]}').submit(); return false;\" href='#' class='#{options[:style]}'>#{options[:label]}</a>"
    return r_safe s
  end

#============================================================================================================================

  def self.sort_by_fields(filter)
    s  = "<input type='hidden' id='filter_sort_by' name='filter[sort_by]' value='#{filter.sort_by}' />"
    s += "<input type='hidden' id='filter_old_sort_by' name='filter[old_sort_by]' value='#{filter.sort_by}' />"
    s += "<input type='hidden' id='filter_sort_by_order' name='filter[old_sort_by_order]' value='#{filter.sort_by_order}' />"
    s += "<input type='hidden' id='filter_sort_by_order_flip' name='filter[sort_by_order_flip]' value='no' />"
    return r_safe s
  end

  def self.sort_by_link(name,field_name,filter=nil,sorter=true)
    s = ''
    if sorter
      s += "<span class='lft darr'>&darr;</span> " if filter && filter.sort_by==field_name && filter.sort_by_order=='ASC'
      s += "<span class='lft uarr'>&uarr;</span> " if filter && filter.sort_by==field_name && filter.sort_by_order=='DESC'
      s += RFilterHelper.js_link("document.getElementById('filter_sort_by').value='#{field_name}';document.getElementById('filter_sort_by_order_flip').value='yes';document.getElementById('filters').submit();",:label=>name)
      s += " <span class='rgh darr'>&darr;</span>" if filter && filter.sort_by==field_name && filter.sort_by_order=='ASC'
      s += " <span class='rgh uarr'>&uarr;</span>" if filter && filter.sort_by==field_name && filter.sort_by_order=='DESC'
    else
      s+= name
    end
    return r_safe s
  end

#============================================================================================================================

  def self.dropdown_field(filter,options={})
    options[:label]        ||= 'error'
    options[:name]         ||= RFilterHelper.generate_dropdown_name_from_label(options[:label])
    options[:value_method] ||= 'id'
    options[:name_method]  ||= 'to_s'
    options[:collection]   ||= instance_variable_get("@#{options[:label].pluralize.downcase}") || []
    options[:pre_fields]   ||= {"all"=>0}
    options[:post_fields]  ||= {}
    selected_value = filter.dropdown_value_for_name(options[:name]).to_i
    s = RFilterHelper.generate_label(options[:label],:break=>options[:break]) 
    s += "<select name='filter[dropdowns][#{options[:name]}]'>".html_safe
      options[:pre_fields].each_pair do |name,value|
        s += "<option value='#{value}' #{selected_value.to_s==value.to_s ? "selected='selected'" : ''}>-#{name}-</option>".html_safe
      end if options[:pre_fields]
      options[:collection].each do |item|
        name  = item.send(options[:name_method])
        value = item.send(options[:value_method])
        s += "<option value='#{value}' #{selected_value.to_i==value.to_i ? "selected='selected'" : ''}>#{name}</option>".html_safe
      end
      options[:post_fields].each_pair do |name,value|
        s += "<option value='#{value}' #{selected_value.to_s==value.to_s ? "selected='selected'" : ''}>-#{name}-</option>".html_safe
      end if options[:post_fields]
    s += "</select>".html_safe
    return s
  end

#============================================================================================================================

  def self.custom_dropdown_field(filter,options={})
    options[:label]        ||= 'error'
    options[:name]         ||= RFilterHelper.generate_custom_name_from_label(options[:label])
    options[:value_method] ||= 'to_s'
    options[:name_method]  ||= 'titleize'
    options[:collection]   ||= []
    options[:pre_fields]   ||= {"all"=>0}
    options[:post_fields]  ||= {}
    selected_value = filter.custom_field_value_for_name(options[:name]).to_s
    s = RFilterHelper.generate_label(options[:label],:break=>options[:break])
    s += "<select name='filter[custom_fields][#{options[:name]}]'>".html_safe
      options[:pre_fields].each_pair do |name,value|
        s += "<option value='#{value}' #{selected_value.to_s==value.to_s ? "selected='selected'" : ''}>-#{name}-</option>"
      end if options[:pre_fields]
      options[:collection].each do |item|
        name  = item.send(options[:name_method])
        value = item.send(options[:value_method])
        s += "<option value='#{value}' #{selected_value.to_s==value.to_s ? "selected='selected'" : ''}>#{name}</option>"
      end
      options[:post_fields].each_pair do |name,value|
        s += "<option value='#{value}' #{selected_value.to_s==value.to_s ? "selected='selected'" : ''}>-#{name}-</option>"
      end if options[:post_fields]
    s += "</select>"
    return r_safe s
  end

#============================================================================================================================

  def self.boolean_dropdown_field(filter,options={})
    options[:label]  ||= 'error'
    options[:name]   ||= RFilterHelper.generate_custom_name_from_label(options[:label])
    options[:fields] ||= ['n/a','yes','no']
    options[:fields]   = ['n/a','yes','no'] if options[:fields].size < 3
    selected_value = filter.boolean_field_value_for_name(options[:name])
    s = RFilterHelper.generate_label(options[:label],:break=>options[:break])
    s += "<select name='filter[boolean_fields][#{options[:name]}]'>".html_safe
      s += "<option value='#{RFilter::BOOLEAN_VALUE_FOR_ALL}' #{selected_value==RFilter::BOOLEAN_VALUE_FOR_ALL ? "selected='selected'" : ''}>#{options[:fields][0]}</option>".html_safe
      s += "<option value='1' #{selected_value==1 ? "selected='selected'" : ''}>#{options[:fields][1]}</option>".html_safe
      s += "<option value='0' #{selected_value==0 ? "selected='selected'" : ''}>#{options[:fields][2]}</option>".html_safe
    s += "</select>".html_safe
    return r_safe s
  end


#============================================================================================================================

  class DateHelper
    include ActionView::Helpers::DateHelper
  end

  def self.date_range_fields(filter,options={})
    helper = DateHelper.new
    options[:label] ||= 'error'
    options[:name]  ||= options[:label].downcase.gsub(' ','_')
    options[:null]  ||=
    s = RFilterHelper.generate_label(options[:label],:postfix=>'After',:break=>options[:break])
    s += helper.date_select(
      "filter[dates][#{options[:name]}_after]",
      "date",
      :order=>[:day, :month, :year],
      :default=>filter.date_after_for_name(options[:name])
    )
    s += RFilterHelper.generate_label('-'+options[:label],:postfix=>'Before',:break=>options[:break])
    s += helper.date_select(
      "filter[dates][#{options[:name]}_before]",
      "date",
      :order => [:day, :month, :year],
      :default=>filter.date_before_for_name(options[:name])
    )
    return r_safe s
  end

#============================================================================================================================

  def self.search_field(filter,options={})
    options[:label] ||= 'Search For' 
    options[:style] ||= '' 
    options[:name]  ||= 'search_for' 
    s = RFilterHelper.generate_label(options[:label],:break=>options[:break]).html_safe
    s = '' if options[:label] == 'none'
    s += "<input type='text' name='filter[#{options[:name]}]' class='search #{options[:style]}' value=\"#{RFilter.sanitize_str(filter.search_string)}\">".html_safe
    return r_safe s
  end

#============================================================================================================================

  def self.reset_link(options={})
    options[:title]  ||= 'Resets the Filter to its default settings'
    options[:label]  ||= 'Reset'
    options[:style]  ||= 'dark'
    options[:target] ||= '?'
    return r_safe "<a title='#{options[:title]}' href='#{options[:target]}' class='#{options[:style]}'>#{options[:label]}</a>"
  end

  def self.submit_link(options={})
    options[:title]   ||= 'Filter list according to current filter settings'
    options[:label]   ||= 'Search'
    options[:form_id] ||= 'filters'
    options[:style]   ||= ''
    return r_safe "<a title='#{options[:title]}' onclick=\"document.getElementById('#{options[:form_id]}').submit(); return false;\" href='#' class='#{options[:style]}'>#{options[:label]}</a>"
  end

  def self.default_links(submit_options={},reset_options={})
    return r_safe(RFilterHelper.reset_link(reset_options)+' '+RFilterHelper.submit_link(submit_options))
  end

#============================================================================================================================
private

  DIVIDER_SUBSTR = "-"
  DIVIDER_STR = "<span class='divider'>&middot;&middot;&middot;</span> "

  def self.generate_label(label,options={})
    s = label.gsub(RFilterHelper::DIVIDER_SUBSTR,RFilterHelper::DIVIDER_STR)
    s = "#{s} #{options[:postfix]}" if options && options[:postfix] && options[:postfix].to_s.length>0
    s += ': '
    s += '<br/>' if options && options[:break]
    return r_safe s
  end

  def self.generate_dropdown_name_from_label(label)
    n = label.gsub(RFilterHelper::DIVIDER_SUBSTR,'')
    n.gsub!(' ','_')
    return r_safe "#{n.downcase}_id"
  end

  def self.generate_custom_name_from_label(label)
    n = label.gsub(RFilterHelper::DIVIDER_SUBSTR,'')
    n.gsub!(' ','_')
    return n.downcase
  end

  def self.js_link(js_fcn,options={})
    options[:label] ||= 'Go'
    options[:style] ||= ''
    options[:title] ||= 'JavaScript Action'
    s = "<a href='#' onclick=\"#{js_fcn}\" title=#{options[:title]} class='#{options[:style]}'>#{options[:label]}</a>"
  end

#============================================================================================================================
#============================================================================================================================
end
