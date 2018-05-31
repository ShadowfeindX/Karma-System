module System
  extend self
  attr_reader :report_emoji
  attr_accessor :roles

  @blacklist = {}
  @roles = {}

  def init
    p @roles
    @report_emoji  = '☢'
    @admin_channel = BOT.find_channel 'administration'
  end

  def induct(member, reason)
    member.add_role @roles[:Member], reason
    member.remove_role @roles[:Visitor], reason
  end

  def blacklisted?(message)
    @blacklist[message] != nil
  end

  def clear(id)
    alert, _ = @blacklist[id]
    alert.delete
    @blacklist.delete id
  end

  def report(message)
    if (blacklist = @blacklist[message.id])
      alert, count = blacklist
      warning = <<-WARN
The following message has been reported by #{count += 1} users:
```      
#{message.content}
```
      WARN
      alert.edit warning
    else
      warning = <<-WARN
The following message has been reported:
```
#{message.content}
```
      WARN
      @blacklist[message.id] = [@admin_channel.send_message(warning), 1]
    end
  end

end
