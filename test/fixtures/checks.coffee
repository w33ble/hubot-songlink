{ expect } = require 'chai'
responseBody = require './response'

module.exports =
  checkBotResponse: (messages) ->
    expect(messages).to.have.lengthOf 2
    expect(messages[1]).to.eql [
      'hubot'
      "#{responseBody.artist} - #{responseBody.title} | #{responseBody.share_link}"
    ]

  checkNoBotResponse: (messages) ->
    expect(messages).to.have.lengthOf 1
