module RController
#--------------------------------------------------------------------------------------------------------------------------------

  def model_name
    controller_name.singularize.camelize.constantize
  end
  def model_sym
    controller_name.singularize.to_sym
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def index
    @filter = RFilter.new
    filter_settings
    @filter.adjust_for_parameters(params)
    
    @items_count = model_name.count(:conditions=>@filter.sql_conditions)
    @objects     = model_name.paginate(:all,:page=>params[:page],
      :per_page   => @perpage || @filter.perpage,
      :order      => @sortorder || @filter.sql_sortorder,
      :conditions => @conditions || @filter.sql_conditions
    )

    do_before_each
    respond_to do |format|
      do_after_each
      format.html # index.html.erb
      format.xml  { render :xml => @objects }
    end
  end
  
  def filter_settings
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def show
    @filter = RFilter.new
    @object = model_name.find(params[:id])
    do_before_each

    respond_to do |format|
      do_after_each
      format.html # show.html.erb
      format.xml  { render :xml => @object }
    end
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def new
    @object = model_name.new
    do_before_each

    respond_to do |format|
      do_after_each
      format.html # new.html.erb
      format.xml  { render :xml => @object }
    end
  end

  def create
    @object = model_name.new(params[model_sym])
    do_before_create
    do_before_save
    do_before_each

    respond_to do |format|
      if @object.save
        @object.log_event(current_user,action_name)
        do_after_create
        do_after_save
        do_after_each
        format.html { redirect_to(@object, :notice => 'Object was successfully created.') }
        format.xml  { render :xml => @object, :status => :created, :location => @object }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @object.errors, :status => :unprocessable_entity }
      end
    end
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def edit
    @object = model_name.find(params[:id])
    do_before_each
    do_after_each
  end

  def update
    @object = model_name.find(params[:id])
    do_before_update
    do_before_save
    do_before_each

    respond_to do |format|
      if @object.update_attributes(params[model_sym])
        @object.log_event(current_user,action_name)
        do_after_update
        do_after_save
        do_after_each
        format.html { redirect_to(@object, :notice => 'Object was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @object.errors, :status => :unprocessable_entity }
      end
    end
  end

#--------------------------------------------------------------------------------------------------------------------------------

  def destroy
    @object = model_name.find(params[:id])

    do_before_each
    @object.destroy
    do_after_each

    respond_to do |format|
      format.html { redirect_to("/#{model_sym.to_s.pluralize}") }
      format.xml  { head :ok }
    end
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def do_before_create
  end
  def do_before_update
  end
  def do_before_save
  end

  def do_after_create
  end
  def do_after_update
  end
  def do_after_save
  end

  def do_before_each
  end
  def do_after_each
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end
