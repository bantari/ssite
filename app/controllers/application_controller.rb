class ApplicationController < ActionController::Base
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  before_filter :authenticate_user!
  protect_from_forgery

  before_filter :before_all_global
  before_filter :before_all
    
def after_sign_out_path_for(resource)
  	'/products'
end

#--------------------------------------------------------------------------------------------------------------------------------

  DEVISE_CONTROLLERS = %w(sessions registrations passwords)

  def before_all_global
    @current_controller = controller_name
    @current_action     = action_name
    @devise_action      = DEVISE_CONTROLLERS.include?(@current_controller)
  end
  def before_all
  end
  
#--------------------------------------------------------------------------------------------------------------------------------

  def success(msg)
    "<span class='success'><b>Success</b> &rarr; #{msg}</span>".html_safe
  end
  def failure(msg)
    "<span class='failure'><b>Failure</b> &rarr; #{msg}</span>".html_safe
  end
  
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  helper_method :is_admin?, :is_developer?
  
  def is_admin?
    return false unless current_user
    return current_user.admin
  end
  
  def is_developer?
    return false unless current_user
    return current_user.developer
  end

#--------------------------------------------------------------------------------------------------------------------------------

  helper_method :has_roles?, :has_roles_either?

  def has_roles?(*roles)
    return false unless current_user
    return current_user.has_roles?(*roles) || false
  end

  def has_roles_either?(*roles)
    return false unless current_user
    return current_user.has_roles_either?(*roles) || false
  end

#--------------------------------------------------------------------------------------------------------------------------------

  helper_method :can_see?, :can_create?, :can_edit?, :can_destroy?, :can_release?

  def can_see?(*items)
    return false unless current_user
    return current_user.can_see?(*items) || false
  end
  def can_create?(*items)
    return false unless current_user
    return current_user.can_create?(*items) || false
  end
  def can_edit?(*items)
    return false unless current_user
    return current_user.can_edit?(*items) || false
  end
  def can_destroy?(*items)
    return false unless current_user
    return current_user.can_destroy?(*items) || false
  end
  def can_release?(*items)
    return false unless current_user
    return current_user.can_see?(*items) || false
  end


#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
protected

  def live_data_flag
    "<span class='flag live_data'>!! live data !!</span>".html_safe
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end
