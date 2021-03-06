#!/usr/bin/env ruby

require_relative 'settings.rb'

puts "Starting #{NAME}..."
at_exit { BOT.stop true }
trap(:SIGINT) { exit }

def reload
  BOT.clear!

  load 'lib/karma.rb'
  load 'lib/system.rb'
  load 'lib/hooks.rb'

  warn 'Reloaded!'
end

trap(:SIGTERM) { reload }

load 'lib/karma.rb'
load 'lib/system.rb'
load 'lib/hooks.rb'

BOT.ready {
  # BOT.profile.username = NAME
  # BOT.profile.avatar = AVATAR


  Karma.init
  System.init

  roles = BOT.servers.values[0].roles
  %w[^Visitor ^Member ^Moderator ^Admins ^RING].collect { |role|
    reg = Regexp.compile role
    (System.roles[role[1..-1].to_sym] = roles.find { |r| r.name =~ reg }).id
  }.each_with_index { |role, i|
    BOT.set_role_permission role, i+1
  }

  p System.roles

  reload
}

BOT.run
