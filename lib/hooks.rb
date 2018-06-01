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
$history ||= {}

  if $history[event.channel.id]
    case event.content.to_sym
    when :about
      event << 'Our lord and savior, the gracious admin, **shadow** has documented the entirety of my specs here:'
      event << 'https://github.com/ShadowfeindX/Karma-System/blob/master/README.md'
    when :source
      event << 'You can find the perpetual spaghetti that is my internal organs sprawled across this repo:'
      event << 'https://github.com/ShadowfeindX/Karma-System'
    when :creator
      event << '~~Who cares about that lazy asshole.~~'
      event << 'My precious creator goes by the name of **shadow** aka **ShadowfeindX**.'
      event << 'You can view more of his ~~abominations~~ projects here:'
      event << 'https://github.com/ShadowfeindX'
    when :backstory
      event << '**I was a real boy!**'
      event << '*once...*'
    when :emojis
      event << '**__Emoji Listing__**'
      event << <<-EMOJIS
Up-Vote: 👆
Down-Vote: 👇
Toxic (Report that hoe): ☢
Recipro-burst (Admin-only): 🌟
Super Down-Vote (Admin-only):  📛
      EMOJIS
    when :restart
      event << 'If you insist'
      $history.delete event.channel.id
    else
      $history.delete event.channel.id if ($history[event.channel.id] += 1) == 3
      event << "I\'m sorry #{event.author.mention}, I can't let you do that..."
    end
  else
  $history[event.channel.id] = 0
  event << <<-INFO
***INFIDEL!***

JK! Aloha, **compadre**!
I suppose you're here to learn about some of my cool features!
Fortunately for you, **I am fully equipped to answer a limited range of 1 word directives!**

```
backstory
source
creator
emojis
about
restart
```
  INFO
  end
}

BOT.command :stats, max_args: 1, usage: '`@Karma stats optional[user]`' do |e, u|
  member = e.author
  member = BOT.parse_mention(u).on e.server if u
  Karma.stats member
end

BOT.command :ranks, max_args: 1, usage: '`@Karma ranks optional[top]`' do |e, top|
  users = Karma.ranking top: (top || 10)
  e << '***Karma Leaderboard:***'
  return nil unless users.reverse_each.with_index { |u,i|
    e << "#{i+1}:  <@#{u[:id]}>"
  }.empty?
  
  e.drain
  "Nobody likes me...😢😢"
end

BOT.command :help do
  'If you want to know more about me, slide into my dm\'s 😉😉'
end

BOT.command :author do
  'Lovingly crafted by: <@!249991058132434945>!'
end

BOT.command :source do
  "~~a dark basement~~\nhttps://github.com/ShadowfeindX/Karma-System"
end

BOT.command :usage do
  'I\'m in charge of the ratings around here.'
end