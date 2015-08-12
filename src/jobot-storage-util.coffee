# Description:
#   Inspect the data in hubot's brain
#
# Commands:
#   hubot show storage <key> - Display the contents that are persisted in the brain in private[key]
#   hubot set storage <JSON> - set the content of the brain to JSON
#   hubot show users - Display the contents about users that are persisted in the brain

module.exports = (robot) ->
  robot.respond /set storage ([\s\S]*)$/i, (msg) ->
    backup = robot.brain.data
    robot.logger.info "Swapping brain value. Backup:\n#{JSON.stringify robot.brain.data, null, 4}"
    robot.brain.data = JSON.parse(msg.match[1])
    robot.brain.save()
    msg.send "Done, previous brain was #{JSON.stringify backup}"

  robot.respond /show users$/i, (msg) ->
    msg.envelope.user.type = 'chat'
    for own key, user of robot.brain.data.users
      response = "User : #{key}\n"
      for own property, value of user
        response += "#{property}: #{value}\n"
      msg.reply response


  robot.respond /show storage\s*(\S+)?/i, (msg) ->
# Return the brain by silting the json into array of lines,
# then merge the lines in batch of 500, send those batch once at a time.
# Otherwise the output is way too slow or it crashes Hubot
    key = msg.match[1]
    steps = 500
    msg.envelope.user.type = 'chat'
    arrayOfArrayOfMessage = []
    if key and key in Object.keys robot.brain.data['_private']
      arrayOfData = (JSON.stringify(robot.brain.data['_private'][key], null, 4).split('\n'))
    else
      arrayOfData = (JSON.stringify(robot.brain.data, null, 4).split('\n'))
      # msg.reply JSON.stringify(robot.brain.data, null, 4).split('\n')
      # msg.reply ['','b']
    for value, position in arrayOfData
      if arrayOfArrayOfMessage[position//steps]?
        arrayOfArrayOfMessage[position//steps].push value
      else
        arrayOfArrayOfMessage[position//steps] = [value]
     msg.reply arrayOfMessage.reduce((total,message)->total+="\n"+message) for arrayOfMessage in arrayOfArrayOfMessage
