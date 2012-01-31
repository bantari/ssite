class ActionEvent < ActiveRecord::Base
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def self.generate(usr,obj,act,dscr=nil)
    new_event = ActionEvent.create(
      :time        => Time.now,
      :object_id   => obj.id,
      :object_type => obj.class.name,
      :action      => act,
      :description => dscr
    )
    return new_event
  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end
