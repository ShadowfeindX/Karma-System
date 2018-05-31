require 'discordrb'

NAME = 'Karma'
AVATAR = File.open 'avatar.jpg'
BOT = Discordrb::Commands::CommandBot.new type: :bot,
                                          ignore_bots: true,
                                          token: ENV[NAME],
                                          name: NAME,
                                          help_command: :help,
                                          spaces_allowed: true,
                                          prefix: '<@324431781149409280>'


class Object
  alias_method :this, :yield_self
  alias_method :that, :tap
end