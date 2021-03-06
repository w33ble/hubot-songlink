HubotHelper = require 'hubot-test-helper'
nock = require 'nock'

responseBody = require './fixtures/response'
checks = require './fixtures/checks'

helper = new HubotHelper('../index.coffee')

describe 'listening and replying', ->
  link = 'https://itun.es/us/18_Mbb?i=1100742531'

  beforeEach ->
    @room = helper.createRoom()
    nock.disableNetConnect()

    nock('http://www.songl.ink', {
      reqheaders:
        'Content-Type': 'application/json'
    })
    .post '/create',
      source: 'itunes'
      source_id: '1100742531'
    .reply 200, responseBody

  afterEach ->
    @room.destroy()
    nock.cleanAll()

  context 'user says itunes url', ->
    it 'should respond if just a link', ->
      @room.user.say('alice', "#{link}")
      .then => checks.checkBotResponse @room.messages

    it 'should respond if link at end', ->
      @room.user.say('alice', "OMG!!! YOU GUIZ!!!!!! #{link}")
      .then => checks.checkBotResponse @room.messages

    it 'should respond if link at begining', ->
      @room.user.say('alice', "#{link} <3 <3 <3")
      .then => checks.checkBotResponse @room.messages

    it 'should respond if link in text', ->
      @room.user.say('alice', "i am crushing on #{link} right now")
      .then => checks.checkBotResponse @room.messages
