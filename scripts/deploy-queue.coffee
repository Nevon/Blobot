# Description:
#   Keep track of a deploy queue
#
# Commands:
#   Blobot deploy add (<user>|me) Add a user to the queue
#   Blobot deploy remove (<user>|me) Remove a user from the queue
#   Blobot deploy list Show the queue
#   Blobot deploy done Pop the first person from the queue
#
# Examples:
#   Blobot deploy add me
#   Blobot deploy add Markus
#
# Author:
#   Tommy Brunn (http://github.com/Nevon)

class Queue
  constructor: (@robot) ->
    @cache = []
    @robot.brain.on 'loaded', =>
      if @robot.brain.data.deployQueue
        @cache = @robot.brain.data.deployQueue
  add: (user) ->
    queuer = {user: user, date: new Date()}
    @cache.push queuer
    @robot.brain.data.deployQueue = @cache
    queuer
  all: -> @cache
  getByIndex: (index) ->
    @cache[index]
  getByUser: (user) ->
    index = @cache.map((n) -> n.user).indexOf(user)
    @cache[index] 
  deleteByUser: (user) ->
    index = @cache.map((n) -> n.user).indexOf(user)
    queuer = @cache.splice(index, 1)[0]
    @robot.brain.data.deployQueue = @cache
    queuer
  pop: ->
    queuer = @cache.splice(0,1)[0]
    @robot.brain.data.deployQueue = @cache
    queuer

module.exports = (robot) ->
  queue = new Queue robot

  formatDate = (date) ->
    normalisedDate = new Date(date - (date.getTimezoneOffset() * 60 * 1000))
    normalisedDate = normalisedDate.toISOString().replace /(\.\d{3}Z)/g, ''
    normalisedDate.replace /(T)/g, ' '    

  robot.respond /deploy add @?([\w .\-]+)\?*$/i, (msg) ->
    user = msg.match[1]
    recipient = "#{user} is"
    if user == "me"
      user = msg.message.user.name
      recipient = "You are"
    userInQueue = queue.getByUser user
    if !userInQueue
      queuer = queue.add user
      msg.send "Certainly, #{queuer.user}"
    else
      msg.send "#{recipient} already in the queue, #{msg.message.user.name}"

  robot.respond /(deploy list|list deploy)/i, (msg) ->
    if queue.all().length > 0
      response = ""
      for queuer, num in queue.all()
        response += "\n##{num} - #{queuer.user} (#{formatDate new Date(queuer.date)})"
      msg.send response
    else
      msg.send "The deploy queue is currently empty (add yourself to it using \"deploy add me\")"

  robot.respond /(deploy done)/i, (msg) ->
    queuer = queue.pop()
    response = ""
    if queuer
      response += "Well done, #{queuer.user}!"
    else
      response += "Sorry, but the queue is already empty"
    next = queue.getByIndex(0)
    if next
      response += "\nPlease give the deployment hat to #{next.user}"
    msg.send response

  robot.respond /(deploy remove @?([\w .\-]+)\?*$)/i, (msg) ->
    user = msg.match[1]
    queuer = queue.deleteByUser user
    if queuer
      msg.send "Removed #{user} from queue"
    else
      msg.send "#{user} is not in the queue"