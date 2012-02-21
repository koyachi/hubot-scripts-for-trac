config = require '../config/trac'

sendMessage = (msg, matched) ->
  parts = matched.split(/[\#|r]/i).map (part) ->
    part.replace(/\s/, '')

  if matched.match(/\#/)
    msg.send config.track_ticket_url(parts[1])
  else
    msg.send config.track_changeset_url(parts[1])

sendMessages = (msg) ->
  for matched in msg.match
    sendMessage msg, matched

module.exports = (robot) ->
  robot.hear /[^\w](\#|r)(\d+)/ig, (msg) ->
    sendMessages msg

  robot.hear /^(\#|r)(\d+)/ig, (msg) ->
    sendMessages msg
