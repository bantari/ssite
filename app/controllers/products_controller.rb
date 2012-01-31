class ProductsController < ApplicationController
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

  [:search,:overview,:specifications,:css_styles,:documents,:media].each do |field|

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

  def edit_products
    @object = Product.find(params[:id])
  end

  def update_products
    @object = Product.find(params[:id])
    if @object.update_attributes(params[:product])
      EventLogger.log(current_user,@object,action_name)
      redirect_to("/products/#{@object.id}?show[products]=yes", :notice=>"Object's Products updated.")
    else
      render :action => "edit_products"
    end
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def show_with_actions
    @object    = Product.find(params[:id])
    @filter    = RFilter.new
    parameters = ''
    notice     = ''
    
    if params[:activate_sku]
      sku = Sku.first(:conditions=>{:id=>params[:activate_sku]})
      if sku
        sku.activate
        notice = success("SKU [#{sku.code}] activated.")
        notice = success("SKU [#{sku.code}] disabled.") unless sku.active
      else
        notice = failure("Unable to find SKU with id=[#{params[:activate_sku]}].")
      end
    end

    redirect_to "/products/#{@object.id}#{parameters}", :notice=>notice
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end
