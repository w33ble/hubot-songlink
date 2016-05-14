HubotHelper = require 'hubot-test-helper'
nock = require 'nock'

responseBody = require './fixtures/response'
checks = require './fixtures/checks'

helper = new HubotHelper('../index.coffee')

describe 'listening and replying', ->
  beforeEach ->
    @room = helper.createRoom()
    nock.disableNetConnect()

    nock('http://www.songl.ink')
    .post '/create',
      source: 'itunes'
      id: '1100742531'
    .reply 200, responseBody

  afterEach ->
    @room.destroy()
    nock.cleanAll()

  context 'user says itunes url', ->
    it 'should respond if just a link', ->
      @room.user.say('alice', 'https://itun.es/us/18_Mbb?i=1100742531')
      .then => checks.checkBotResponse @room.messages

    it 'should respond if link at end', ->
      @room.user.say('alice', 'OMG!!! YOU GUIZ!!!!!! https://itun.es/us/18_Mbb?i=1100742531')
      .then => checks.checkBotResponse @room.messages

    it 'should respond if link at begining', ->
      @room.user.say('alice', 'https://itun.es/us/18_Mbb?i=1100742531 <3 <3 <3')
      .then => checks.checkBotResponse @room.messages

    it 'should respond if link in text', ->
      @room.user.say('alice', 'i am crushing on https://itun.es/us/18_Mbb?i=1100742531 right now')
      .then => checks.checkBotResponse @room.messages
