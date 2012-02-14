config = require '../config/config'

module.exports = (robot) ->
  robot.hear /(\#|r)(\d+)/i, (msg) ->
    matched_id = msg.match[2]
    if msg.match[1] == '\#'
      msg.send config.track_ticket_url(matched_id)
    else
      msg.send config.track_changeset_url(matched_id)

