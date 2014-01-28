# Description:
#   Provides some info about the bot
#
# Commands:
#   hubot info - Show info about the bot
#
# Dependencies:
#   None
#
# Author:
#   Nevon

module.exports = (robot) ->
  robot.respond /info/i, (msg) ->
      lines = [
        "Hi, my name is #{robot.name}!",
        "I'm a chat bot put together and maintained by Tommy Brunn (tommy.brunn@blocket.se).",
        "",
        "If you want to mess around with my brain (plz no...), you can get it at https://github.com/Nevon/blobot",
        "There, you can also find some documentation on how to teach me to do new things."
        ]
      msg.send lines.join('\n')

