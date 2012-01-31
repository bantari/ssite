module RControllerExtras
#--------------------------------------------------------------------------------------------------------------------------------

  def model_name
    controller_name.singularize.camelize.constantize
  end
  def model_sym
    controller_name.singularize.to_sym
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def activate
    @object = model_name.find(params[:id])
    @object.activate
    msg = 'Object de-activated.'
    msg = 'Object activated.' if @object.active
    @object.log_event(current_user,action_name,msg)
    redirect_to(@object, :notice => msg)
  end

  def publish
    @object = model_name.find(params[:id])
    result = ''
    #@object.publish_all
    @object.log_event(current_user,action_name,result)
    redirect_to("/#{@object.table_name}/#{@object.id}?show[releases]=yes", :notice => 'Object was successfully published.')
  end

  def delete
    @object = model_name.find(params[:id])
    #@object.destroy
    redirect_to("/#{model_sym.to_s.pluralize}", :notice => 'Object deleted.')
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end