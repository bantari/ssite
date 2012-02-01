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
    msg = 'disabled'
    msg = 'enabled' if @object.active
    notice = "Object #{msg}."
    EventLogger.log(current_user,@object,msg)
    redirect_to(@object, :notice => notice)
  end

  def publish
    @object = model_name.find(params[:id])
    result = ''
    #@object.publish_all
    EventLogger.log(current_user,@object,action_name,result)
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