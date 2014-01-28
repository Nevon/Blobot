# Description:
#   Tell people hubot's new name if they use an old one.
#
# Commands:
#   None
#
module.exports = (robot) ->
  robot.hear /^(hubot|rocket|rocket.bot):? (.+)/i, (msg) ->
    response = "Sorry, I'm a diva and only respond to #{robot.name}"
    response += " or #{robot.alias}" if robot.alias
    msg.reply response
