# Greetings, @everyone!
Welcome to the official @Experimental release of @Karma! Many of you are already familiar with how karma systems work elsewhere, but CSST's Discord Karma has a few features that I think are worth noting.

+ Karma Ratio
+ Karmic Zero
+ Karma Bonuses
+ Karma Streaks
+ Karma Strength
+ Karma Decay
+ Prestige Mode
+ Karma Ranking
+ Karma Stats

The @Karma system will work on the basic concept of a **Karma Ratio**. When you recieve upvotes and downvotes, both values are stored and your **Karma Level** becomes a ratio of these two values. Essentially what this means is that instead of having a **Karma Level** of `3` or `10`, you will have levels like `2.9` and `6.2`. This also means that there are no *soft caps* or *hard caps* on the level of Karma you can reach and there is no set amount of upvotes required for each Karma level.

### Karmic Zero
___
Represents the lowest **Karma Level** a user can have. Since your Karma Level is a ratio, this number can obviously not be the literal value of `0` because that would be stupid. Instead, Karmic Zero for Discord Karma is `0.01`. This means that in order to achieve a **Karma Level** of `1`, you need **at least 100 upvotes**. This might sound like a lot, but the next few features will balance this out. **The starting level for users of the @Karma system is `0.03`.**

### Karma Bonuses
___
The @Karma system's way of feeding the masses. Every `10` upvotes or downvotes you recieve on a message will add a kind of *multiplier* to future votes. The multiplier is currently `base 2` meaning: after the first `10` votes, every additional vote will count **twice**, after the next `10` they will count **4 times**. Note this applies to the number of voters and not the vote values themselves. Achieving a `4x` karma bonus requires **at least 20 people to vote the same way on your message**.

### Karma Streaks
___
The @Karma system's way of praising helpful users and punishing repeat offenders. Just like the name suggests, the @Karma system applies another muliplier to repeated votes across multiple messages. For every message in a row that recieves **only upvotes**, you will recieve a bonus upvote on your next message. This means that if you send 5 messages and 3 of them are upvoted, your next message will **automatically get 3 additional upvotes when it's first upvoted** as long as and **none of your other 5 messages have been downvoted**. The same applies to repeatedly downvoted messages. Note this may eventually change to a system that takes into account the total positivity or negativity of messages.

### Karma Strength
___
Simply refers to the value of a particular user's vote. By default, @Visitors are worth `0.2` votes, @Members are worth `1` vote, @Moderators are worth `5` votes, and @Admins are worth `10` votes. Note this may eventually also include your **Karma Level** as some form of multiplier.


### Karma Decay
___
Something like the opposite of **Karma Streaks**. Every day you will lose `1` upvote from your karma. Every `10` days without an upvote will increase your decay rate by a `power of 2`. Meaning, over the first `10` days you will lose 1 upvote per day. If you have not recieved an upvote by the 11th day, you will be losing 2 upvotes per day. Then 4 and so on.

### Prestige Mode
___
Probably the stupidest part of the @Karma system, but I added it anyway. Basically, since there is no cap on your **Karma Level** the numbers have a slight chance to get out of control. **Prestige Mode** will allow you to **reset your level to Karmic Zero** aka `0.01`. Since there's no real reason to do this without some kind of incentive, those who prestige will recieve a **permanant Karmic Bonus every time they prestige**. To unlock this option you have a **Karma Level** of at least `1`. This will reset all your upvotes and downvotes, meaning that if you have a particularly high number of downvotes, you can potentially reach a higher level after Prestige than you could without it.

### Karma Ranking
___
A pretty straightforward concept. You will be ranked based on your **Karma Levels**. The top 3 every week will probably get a reward in the future, but for now it's just a friendly scoreboard.

### Karma Stats
___
Just a weird feature I tacked on. They track each users use of the @Karma system. Your **Karma Level, Karma Strength, Karma Ranking, total upvotes, total downvotes, longest positive streak, longest negative streak, largest karma bonus, smallest karma bonus, Karma Decay Rate, and Presitge Level** will all be stored and updated as part of the system. These information is public and can be viewed by any user with the @Karma command.

### Karma Bursts
___
Methods of dramatically altering a users **Karma Level**. A positive karma burst will **move a user to the next karma level**. Meaning if you receive a **Karma Burst** while at level `1.2` your new level will be `2.0`. A negative karma burst will **take a user to the previous Karma Level**. This means that if you reciece a **Karma Burst** while at level `3.9`, your new level will be `3.0`. This is an @Admins only feature that may eventually be extended to @Moderators as well.

## ***Bonus Features:***
___
**Users whose karma level drops below Karmic Zero will be kicked.**

**@Visitors will become @Members after reaching Karma Level 1!**

**Questions about the @Karma system can be asked directly of @Karma via DM!**

**Messages suspected of abusing the system can be tagged with the `☢` emoji!**

**Any issues or abuse of the Karma system or additional questions should be directed to @shadow via DM!**