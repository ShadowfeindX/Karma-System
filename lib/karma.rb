module Karma
  extend self

  attr_reader :upvote_emoji, :downvote_emoji, :upburst_emoji, :downburst_emoji

  def init
    set_emoji
    start_decay
    @strengths = [0.02, 1, 5, 10, 100]
    @users = {}
  end


  def set_emoji
    @upvote_emoji   = '👆'
    @downvote_emoji = '👇'
    @upburst_emoji = '🌟'
    @downburst_emoji = '📛'
  end

  def new_user(id)
   {
     id: id,
     level: 3/100r,
     prestige: 0,
     upvotes: 3,
     downvotes: 100,
     streak: 0,
     up_streak: 0,
     down_streak: 0,
     up_bonus: 0,
     down_bonus: 0,
     decay: 1
   }
  end

  def add(type, event)
    warn "add #{type.to_s}"

    @users ||= init
    user = (@users[id = event.message.author.id] ||= new_user(id))

    case type
    when :prestige
      return {} unless user[:upvotes] >= user[:downvotes]
      p = user[:prestige] + 1
      user.merge! upvotes: 1, downvotes: 100, prestige: p, streak: 0, decay: 0

    when :upburst
      user[:decay] = 0
      user[:upvotes] += user[:downvotes] - (user[:upvotes] % user[:downvotes])

    when :downburst
      if user[:upvotes] <= user[:downvotes]
        user[:upvotes] = (user[:downvotes] * 0.01).round
      else
        user[:upvotes] -= user[:upvotes] - (user[:downvotes] % user[:upvotes])
      end
      user

    when :upvotes, :downvotes
      user[type] += calc_vote(event, user, type == :upvotes)
    end

    user.merge! level: Rational(user[:upvotes], user[:downvotes])
  end

  def upvotes(message)
    message.reactions[@upvote_emoji]&.count || 0
  end

  def downvotes(message)
    message.reactions[@downvote_emoji]&.count || 0
  end

  def remove(type, event)
    warn "remove #{type.to_s}"

    user = @users[event.message.author.id]
    s = user[:streak]
    user[type] -= calc_vote(event, user, type == :upvotes, true)
    user[:streak] = s
    user
  end

  def calc_strength(member)
    BOT.instance_exec(member, @strengths) { |user, strength_levels|
      level = user.roles.reduce(0) do |memo, role|
        [@permissions[:roles][role.id] || 0, memo].max
      end
      strength_levels[level - 1]
    }
  end

  def calc_vote(event, user, up = true, undo = false)
    sentinel_new, sentinel_flip =
      if up
        user[:decay] = 0
        i = 1
        [:positive?, :negative?]
      else
        i = -1
        [:negative?, :positive?]
      end

    v = Karma.method(up ? :upvotes : :downvotes).(event.message)
    v += 1 if undo

    karma_bonus  = 2 ** ((v - 1) / 10)
    prestige_bonus = 1 + user[:prestige] * 0.2

    karma_strength = calc_strength event.user

    karma_streak = 0
    if v == 1 && (sentinel_new === user[:streak])
      karma_streak = user[:streak]
      user[:streak] = user[:streak] + i
    elsif sentinel_flip === user[:streak]
      user[:streak] = 0
    end

    user[:up_streak] = [user[:up_streak], karma_streak].max
    user[:down_streak] = -[-user[:down_streak], karma_streak].min

    bonus = up ? :up_bonus : :down_bonus
    user[bonus] = [user[bonus], karma_bonus].max

    (1 * karma_strength * karma_bonus * prestige_bonus + karma_streak).to_i
  end

  def format_user(member, user)
    <<-USER
**Karma Report** for #{member.mention}
```
Karma Level: #{user[:level].to_f.round(2)}
Prestige Level: #{user[:prestige]}
Karma Strength: #{calc_strength member}
Karma Ranking: #{1 + ranking(find_id: user[:id])}
Total Up-Votes: #{user[:upvotes]}
Total Down-Votes: #{user[:downvotes]}
Current Karma Streak: #{user[:streak]}
Longest Up-Vote Streak: #{user[:up_streak]}
Longest Down-Vote Streak: #{user[:down_streak]}
Largest Up-Vote Bonus: #{user[:up_bonus]}
Largest Down-Vote Bonus: #{user[:down_bonus]}
Karma Decay Rate: #{user[:decay]}
```
    USER
  end

  def stats(member)
    format_user member, @users[member.id]
  end

  def ranking(top: 10, by: :level, find_id: nil)
    ranked = @users.values.sort_by { |user| user[by] }
    return ranked.find_index { |user| user[:id] == find_id } if find_id
    ranked.take top
  end

  def start_decay
    @decay = Thread.new {
      loop {
        sleep (t = Time.now.getgm)
                .this { |it| Time.gm(it.year, it.month, it.day, 8) }
                .this { |it| (t > it ? it + 86400 : it) - t.getgm }
        @users.each_value { |user|
          decay = 2 ** (user[:decay] / 10)
          user[:upvotes] -= decay
          user[:decay] += 1
        }
      }
    }
  end

  def stop_decay
    Thread.kill @decay
  end
end





