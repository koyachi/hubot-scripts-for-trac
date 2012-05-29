config = require '../config/trac'
jsdom = require 'jsdom'
jqueryJs = 'https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js'

getTicketTitle = (url, f) ->
  jsdom.env url, [jqueryJs], (err, window) ->
    title = window.$('h2.summary.searchable').text().replace(/[\r|\n]+/g, '')
    f title

sendMessage = (msg, matched) ->
  parts = matched.split(/[\#|r]/i).map (part) ->
    part.replace(/\s/, '')

  if matched.match(/\#/)
    getTicketTitle config.track_ticket_url(parts[1]), (title) ->
      msg.send "#{config.track_ticket_url(parts[1])} #{title}"
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
