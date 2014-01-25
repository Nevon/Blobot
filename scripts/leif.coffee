# Description:
#   Leif Andersson
#
# Commands:
#   hubot tusen - Tuuuuusen.

quotes = ["Sackert!", "Var i alla mhhhnn...", "Zenom tusen", "Bzzzzhhzzz"]

module.exports = (robot) ->
  robot.respond /(tusen|zuzen)/i, (msg) ->
    quote = msg.random quotes
    msg.reply "#{quote}\nhttps://www.youtube.com/watch?v=u1iq02y5RAU"