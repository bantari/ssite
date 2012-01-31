# Manages filtering conditions for displaying item lists
# Sets condition for the SQL search
class RFilter
#==============================================================================================

  VERY_LARGE_NUMBER      = 100000

  DEFAULT_DATE_AFTER     = Date.civil(2007, 1, 1)
  DEFAULT_DATE_BEFORE    = Date.civil(2012,12,31)

  DROPDOWN_DEFAULT_VALUE = 0
  CUSTOM_DEFAULT_VALUE   = nil
  CUSTOM_VALUE_FOR_ALL   = '0'
  BOOLEAN_VALUE_FOR_ALL  = -1
  
  attr_accessor :items_per_page
  attr_accessor :paginate
  
  attr_accessor :dropdowns
  attr_accessor :ignored_dropdowns
  attr_accessor :dropdown_sortorders
  attr_accessor :dropdown_conditions
  attr_accessor :custom_fields
  attr_accessor :boolean_fields

  attr_accessor :dates
  
  attr_accessor :search_fields
  attr_accessor :search_string

  attr_accessor :sql_sortorder
  attr_accessor :sql_conditions
  attr_accessor :mandatory_condition
  
  attr_accessor :old_sort_by
  attr_accessor :sort_by
  attr_accessor :sort_by_order

#==============================================================================================
#==============================================================================================

  def initialize
    self.items_per_page      = 20
    self.paginate            = true
    self.dropdowns           = {}
    self.ignored_dropdowns   = []
    self.dropdown_conditions = {}
    self.dropdown_sortorders = {}
    self.custom_fields       = {}
    self.boolean_fields      = {}
    self.dates               = {}
    self.search_fields       = []
    self.search_string       = nil
    self.sql_sortorder       = 'id DESC'

    self.sort_by             = 'id'
    self.sort_by_order       = 'ASC'

    self.sql_conditions      = ''
    self.mandatory_condition = ''
    generate_sql_conditions
  end
  
#==============================================================================================
#==============================================================================================
# PAGINATION

  def perpage
    return self.items_per_page if paginate
    return VERY_LARGE_NUMBER
  end
  
  def set_paginate(value)
    self.paginate = value == true 
  end
  
  def set_perpage(number)
    self.items_per_page = number.to_i if number
  end

  def set_items_per_page(number)
    self.items_per_page = number.to_i if number
  end

  def pagination_msg
    return " (#{self.items_per_page} per page)" if paginate
    return ''
  end

#==============================================================================================
#==============================================================================================
# SORT ORDER

  # deprecated - do not use if also using sorting links
  def set_sortorder(order)
    puts "RFilter.set_sortorder is DEPRECATED - use RFilter.set_sort_by_and_order instead"
    self.sql_sortorder = order
  end
  
  def set_sort_by_and_order(s_by,s_by_order='ASC')
    self.sort_by = s_by
    self.sort_by_order = s_by_order
    self.sql_sortorder = "#{self.sort_by} #{self.sort_by_order}"
  end
  
#==============================================================================================
#==============================================================================================
# MANDATORY CONDITION

  def set_mandatory_condition(condition)
    self.mandatory_condition = ''
    self.mandatory_condition = condition if condition && condition.length>0
  end

#==============================================================================================
#==============================================================================================
# SEARCH FIELDS

  # Sets names for list dropdown fields
  # The corresponding default values will all be set to 0
  def register_search_fields(*names)
    names.each do |name|
      search_fields << name.to_s
    end
  end
  
#==============================================================================================
#==============================================================================================
# DROPDOWN FIELDS

  # Sets names for list dropdown fields
  # The corresponding default values will all be set to 0
  def register_dropdowns(*names)
    names.each do |name|
      dropdowns[name.to_s] = {}
      dropdowns[name.to_s]["label"] = name.to_s
      dropdowns[name.to_s]["value"] = DROPDOWN_DEFAULT_VALUE
    end
  end
  
  # Determine which dropdowns will not make it to the sql_conditions
  # - they will be handled externally
  def register_ignored_dropdowns(*names)
    names.each do |name|
      ignored_dropdowns << name.to_s
    end
    ignored_dropdowns.uniq!
  end

  # Custom conditions for specific field/value combos
  def set_dropdown_condition(name,value,condition)
    self.dropdown_conditions["#{name.to_s}_#{value}"] = condition
  end
  
  # Custom sort_order for specific field/value combos
  def set_dropdown_sortorder(name,value,order)
    self.dropdown_sortorders["#{name.to_s}_#{value}"] = order
  end
  
  # Returns the current value for the particular dropdawn
  def dropdown_value_for_name(name)
    return dropdowns[name.to_s]["value"].to_i if dropdowns[name.to_s]
    return 0 # if no name found
  end

  # Returns the current value for the particular dropdawn
  def set_dropdown_value_for_name(name,value)
    if dropdowns[name.to_s]
      dropdowns[name.to_s]["value"] = "#{value}" if value
    end
  end

#==============================================================================================
#==============================================================================================
# CUSTOM FIELDS

  def register_custom_fields(*names)
    names.each do |name|
      custom_fields[name.to_s] = {}
      custom_fields[name.to_s]["label"] = name.to_s
      custom_fields[name.to_s]["value"] = CUSTOM_DEFAULT_VALUE
    end
  end

  # Returns the current value for the particular custom field
  def custom_field_value_for_name(name)
    return custom_fields[name.to_s]["value"] if custom_fields[name]
    return 'nil' # if no name found
  end

#==============================================================================================
#==============================================================================================
# BOOLEAN FIELDS

  def register_boolean_fields(*names)
    names.each do |name|
      boolean_fields[name.to_s] = {}
      boolean_fields[name.to_s]["label"] = name.to_s
      boolean_fields[name.to_s]["value"] = BOOLEAN_VALUE_FOR_ALL
    end
  end

  # Returns the current value for the particular boolean field
  def boolean_field_value_for_name(name)
    return boolean_fields[name.to_s]["value"].to_i if boolean_fields[name.to_s]
    return BOOLEAN_VALUE_FOR_ALL # if no name found
  end

  # Returns the current value for the particular boolean field
  def boolean_field_registered?(name)
    return boolean_fields[name.to_s] != nil
  end

#==============================================================================================
#==============================================================================================
# DATE FIELDS

  # Sets names for list date fields
  def register_dates(*names)
    names.each do |name|
      label = "#{name.to_s}_after"
      dates[label] = {}
      dates[label]["label"]  = label
      dates[label]["value"]  = DEFAULT_DATE_AFTER
      dates[label]["field"]  = name.to_s
      dates[label]["operator"] = ">="
      label = "#{name}_before"
      dates[label] = {}
      dates[label]["label"]  = label
      dates[label]["value"]  = DEFAULT_DATE_BEFORE
      dates[label]["field"]  = name.to_s
      dates[label]["operator"] = "<="
    end
  end
  
  def date_after_for_name(name)
    label = "#{name.to_s}_after"
    return dates[label]["value"] if dates[label]
    return DEFAULT_DATE_AFTER # if no name found
  end

  def date_before_for_name(name)
    label = "#{name}_before"
    return dates[label]["value"] if dates[label]
    return DEFAULT_DATE_BEFORE # if no name found
  end

#==============================================================================================
#==============================================================================================
# PARAMS

  # Read passed params
  def adjust_for_parameters(params)
    params = params["filter"] if params["filter"]
   
    #self.paginate = false
    if params && params["paginate"]
      self.paginate = true
      self.paginate = false if params["do_viewall"]
    elsif params && params["viewall"]
      self.paginate = false
      self.paginate = true if params["do_paginate"]
    end
    
    #--- set up perpage
    if params && params["perpage"]
      self.set_items_per_page(params[:perpage])
    end

    params["dropdowns"].each_pair do |name,value|
      dropdowns[name]["value"] = value if dropdowns[name]
    end if params && params["dropdowns"] # do params
      
    params["custom_fields"].each_pair do |name,value|
      custom_fields[name]["value"] = CUSTOM_DEFAULT_VALUE 
      custom_fields[name]["value"] = value if custom_fields[name] && value!=CUSTOM_VALUE_FOR_ALL 
    end if params && params["custom_fields"] # do params
      
    params["boolean_fields"].each_pair do |name,value|
      boolean_fields[name]["value"] = BOOLEAN_VALUE_FOR_ALL 
      boolean_fields[name]["value"] = value if boolean_fields[name] && value!=BOOLEAN_VALUE_FOR_ALL 
    end if params && params["boolean_fields"] # do params
      
    if params[:sort_by] #&& params[:old_sort_by] && params[:old_sort_by_order]
      
      self.sort_by = params[:sort_by]
      self.sort_by_order = params[:old_sort_by_order] == 'ASC' ? 'ASC' : 'DESC'
      if params[:old_sort_by] == params[:sort_by] && params[:sort_by_order_flip] == 'yes'
        self.sort_by_order = params[:old_sort_by_order] == 'DESC' ? 'ASC' : 'DESC'  
      end
      
      self.sql_sortorder = "#{self.sort_by} #{self.sort_by_order}"
      
    end # if sort_order 
      
    params["dates"].each_pair do |name,value|
      if dates[name]
        dates[name]["value"] = Date.new(
          value["date(1i)"].to_i,
          value["date(2i)"].to_i,
          value["date(3i)"].to_i
          )
      end
    end if params && params["dates"] # do params
      
    self.search_string = RFilter.sanitize_sql(params["search_for"]) if params && params["search_for"]

    generate_sql_conditions
  end

#==============================================================================================
# SQL

  def generate_sql_conditions
    self.sql_conditions = ""
    cond = []

    #--- process dropdowns
    self.dropdowns.each_value do |dropdown|
      if !ignored_dropdowns.include?(dropdown["label"])

        # adjust sort order if necessary
        if self.dropdown_sortorders["#{dropdown["label"]}_#{dropdown["value"]}"]
          self.sql_sortorder = self.dropdown_sortorders["#{dropdown["label"]}_#{dropdown["value"]}"]
        end

        # conditions
        if self.dropdown_conditions["#{dropdown["label"]}_#{dropdown["value"]}"]
          cond << self.dropdown_conditions["#{dropdown["label"]}_#{dropdown["value"]}"]
        else
          cond << "#{dropdown['label']} = '#{dropdown['value']}'" if dropdown['value'].to_i>0
        end

      end # if ! ignored
    end # do dropdowns

    #--- process custom_fields
    self.custom_fields.each_value do |custom_field|
      # conditions - do not include if VALUE_FOR_ALL selected
      cond << "#{custom_field['label']} = '#{custom_field['value']}'" if custom_field['value'] && custom_field['value'].to_s!=CUSTOM_VALUE_FOR_ALL 
    end # do custom fields

    #--- process boolean_fields
    self.boolean_fields.each_value do |boolean_field|
      # conditions - do not include if VALUE_FOR_ALL selected
      cond << "#{boolean_field['label']} = '#{boolean_field['value'].to_i}'" if boolean_field['value'] && boolean_field['value'].to_i!=BOOLEAN_VALUE_FOR_ALL
    end # do boolean fields

    #--- process dates
    self.dates.each_value do |date|
      cond << "#{date["field"]} #{date["operator"]} '#{date["value"]}'"
    end # do dates
      
    if search_fields && search_fields.size>0 && search_string && search_string.length>0
      temp_cond = []
      search_fields.each do |search_field|
        temp_cond << "#{search_field} LIKE '%#{search_string}%'"
      end # do search_field
      cond << "(#{ temp_cond.join(' OR ')})"
    end # if search_for

    # append mandatory condition, if any
    cond << "(#{self.mandatory_condition})" if self.mandatory_condition && self.mandatory_condition.length>0

    self.sql_conditions = cond.join(' AND ')
  end

#==============================================================================================
#==============================================================================================

  def self.sanitize_sql(str)
    return nil if str.blank?
    return str.gsub(/\\/, '\&\&').gsub(/'/, "''")
  end

  def self.sanitize_str(str)
    return nil if str.blank?
    return str.gsub(/''/, "'")
  end

# HELPERS/SHORTCUTS

#============================================================================================================================

  def paginate_fields_button
    RFilterHelper.paginate_fields_button(self)
  end
  def paginate_fields
    RFilterHelper.paginate_fields(self)
  end
  def viewall_fields
    RFilterHelper.viewall_fields(self)
  end
  def perpage_field(options={})
    RFilterHelper.perpage_field(self,options)
  end
  def perpage_link(number,options={})
    RFilterHelper.perpage_link(self,number,options)
  end
  def sort_by_fields
    RFilterHelper.sort_by_fields(self)
  end

  def sort_by_link(name,field_name,sorter=true)
    RFilterHelper.sort_filter_link(name,field_name,self,sorter=true)
  end

  def dropdown_field(options={})
    RFilterHelper.dropdown_field(self,options)
  end
  def custom_dropdown_field(options={})
    RFilterHelper.custom_dropdown_field(self,options)
  end
  def boolean_dropdown_field(options={})
    RFilterHelper.boolean_dropdown_field(self,options)
  end
  def date_range_fields(options={})
    RFilterHelper.date_range_fields(self,options)
  end

  def search_field(options={})
    RFilterHelper.search_field(self,options)
  end
  
  def reset_link(options={})
    RFilterHelper.reset_link(options)
  end
  def submit_link(options={})
    RFilterHelper.submit_link(options)
  end
  def default_links(submit_options={},reset_options={})
    RFilterHelper.default_links(submit_options,reset_options)
  end

#==============================================================================================
#==============================================================================================
#==============================================================================================
end
