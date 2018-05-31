BOT.reaction_remove { |e|
  next if System.blacklisted? e.message

  emoji = case e.emoji.name
  when Karma.upvote_emoji
    :upvotes
  when Karma.downvote_emoji
    :downvotes
  else
    next
  end

  p Karma.remove emoji, e
}


BOT.reaction_add { |e|
  next if System.blacklisted? e.message

  emoji = case e.emoji.name
  when Karma.upvote_emoji
    :upvotes
  when Karma.downvote_emoji
    :downvotes
  when Karma.upburst_emoji
    :upburst
  when Karma.downburst_emoji
    :downburst
  else
    next
  end

  p Karma.add emoji, e
}

BOT.reaction_add { |e|
  next unless e.emoji.name == System.report_emoji
  System.report e.message if BOT.permission? e.user, 2, e.server
}

BOT.message_delete { |event|
  System.clear(event.id) if System.blacklisted? event.id
}


BOT.pm { |event|
  event << <<-INFO
Aloha compadre!
I suppose you're here to learn about some of my cool features!
Fortunately for you, ***I DON'T HAVE ANY!***
Ask my creator for an update.
No seriously, I'm sick of only having this one message to send...
  INFO
}

BOT.command :stats, max_args: 1 do |e, u|
  member = e.author
  member = BOT.parse_mention(u).on e.server if u
  Karma.stats member
end

BOT.command :ranks, max_args: 1, usage: '`@Karma ranks [top]`' do |e, top|
  users = Karma.ranking top: (top || 10)
  users.each_with_index { |u,i|
    e << "#{i+1}:  <@#{u[:id]}>"
  }
end

BOT.command :help do
  'If you want to know more about me, slide into my dm\'s 😉😉'
end

BOT.command :author do
  'Lovingly crafted by: <@!249991058132434945>!'
end

BOT.command :source do
  "~~a dark basement~~\nComing soon to a repo near you!"
end

BOT.command :usage do
  'I\'m in charge of the ratings around here.'
end