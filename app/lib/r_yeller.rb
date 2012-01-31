class RYeller
#======================================================================================

  def self.out(text)
    puts "|#{text}".html_safe
  end
  
  def self.say(text)
    out("-- #{text}")
  end
  
  def self.yell(text,options={})
    options[:level] ||= 10
    b = ''.rjust(options[:level].to_i * 5,'=')
    out("#{b} #{text}")
  end
  
  def self.shout(text,options={})
    options[:level] ||= 4
    b = ''.rjust(options[:level].to_i * 5,'=')
    out("#{b} #{text}")
  end
  
  def self.bar(options={})
    options[:level] ||= 10
    yell('',options)
  end
  
#======================================================================================
end