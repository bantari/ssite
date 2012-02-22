class DocumentsController < ApplicationController
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  include RController
  include RControllerExtras
  
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def filter_settings
    @filter.register_search_fields('id','code','name','title','description',
      'm_title','m_keywords','m_description', # meta fields
      's_title','s_keywords','s_description', # search fields
      'a_title','a_keywords','a_description'  # auto fields
    )
    @filter.register_boolean_fields(:active,:adjusted,:published)
  end
  
#--------------------------------------------------------------------------------------------------------------------------------
# generate edit_x and update_x pairs for various fields

  [:search,:abstract,:content].each do |field|

    define_method("edit_#{field}") do
      @object = Product.find(params[:id])
    end
  
    define_method("update_#{field}") do
      @object = Product.find(params[:id])
      if @object.update_attributes(params[model_sym])
        EventLogger.log(current_user,@object,action_name)
        redirect_to("/products/#{@object.id}?show[#{field}]=yes", :notice=>"Object's #{field} updated.")
      else
        render :action => "edit_#{field}"
      end
    end

  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end
