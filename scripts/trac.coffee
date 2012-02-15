config = require '../config/trac'

module.exports = (robot) ->
  robot.hear /(\#|r)(\d+)/ig, (msg) ->
    for matched in msg.match
      if matched[0] == '\#'
        msg.send config.track_ticket_url(matched[1..-1])
      else
        msg.send config.track_changeset_url(matched[1..-1])

