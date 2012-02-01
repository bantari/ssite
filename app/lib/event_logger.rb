class EventLogger
#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------

  def self.log(usr,obj,act,res=nil,comment=nil,options={})
    
    return nil unless obj

    options[:save] = true if options[:save] == nil

    usr     ||= User.first
    res     ||= 'success'
    cmt       = comment
    comment ||= obj.full_identifier if obj.respond_to?(:full_identifier)

    EventLog.generate(usr,obj,act,res,comment)

    if obj.respond_to?(:history)
      event  = "- [#{Time.now}] - [#{usr ? usr.id : '?'}] - #{act}"
      event += " - #{cmt}" unless cmt.blank?
      obj.history = "#{event}<br/>#{obj.history || ''}"
      obj.save! if options[:save]
    end # write history

  end

#--------------------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------------------
end