# Description:
#   Chimes in with helpful Dario's momma jokes
#
# Commands:
#   none

jokes = [
  "Yo momma is so fat, I took a picture of her last Christmas and it's still printing.",
  "Yo momma is so fat when she got on the scale it said, \"I need your weight not your phone number.\"",
  "Yo mamma is so ugly when she tried to join an ugly contest they said, \"Sorry, no professionals.\"",
  "Yo momma's so fat and old when God said, \"Let there be light,\" he asked your mother to move out of the way.",
  "Yo momma's so stupid, she put two quarters in her ears and thought she was listening to 50 Cent.",
  "Yo momma is so fat her bellybutton gets home 15 minutes before she does.",
  "Yo mamma is so fat she doesn't need the internet, because she's already world wide.",
  "Yo momma's so fat she can't even jump to a conclusion.",
  "Yo momma's so ugly, blind people hate to look at her.",
  "Yo mama so ugly she made Justin Bieber say, \"Never.\"",
  "Yo momma's so fat, her baby pictures were taken by satellite.",
  "Yo mama so fat I tried driving around her and I ran out of gas.",
  "Yo momma is so fat you need to take two trains and a bus just to get on her good side.",
  "Yo mamma's so fat, I don't have to make a joke.",
  "Yo momma's so fat, when she gets in an elevator, it has to go down.",
  "When you're with yo mamma, it always feels crowded. Even if you're outside."
]

module.exports = (robot) ->
  robot.hear /Dario(s)?.(tjock|tung|fet|fat|heavy|mamma|morsa)/i, (msg) ->
    joke = msg.random jokes
    msg.send joke.replace /(yo\s)?(momma|mama|mamma)( is|'s)?/ig, "Dario's momma"