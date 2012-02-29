class ErrorLog < ActiveRecord::Base
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  #--- associations
  belongs_to :user

#--------------------------------------------------------------------------------------------------------------------------------

  def self.generate(usr,obj,msg)
    return unless obj
    new_log = ErrorLog.create(

      :time        => Time.now,

      :user_id     => usr ? usr.id : 1,
      :object_id   => obj ? obj.id : nil,
      :object_type => obj ? obj.class.name : nil,
      :object_name => obj ? "#{obj.id} #{obj.class.name}" : nil,

      :message     => msg,

      :controller_name => controller.controller_name,
      :action_name     => controller.action_name,

      :app_id      => 1
    )
    return new_log
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end
