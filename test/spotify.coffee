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
      source: 'spotify'
      id: '2zvXUc9nn5Uwer8dbWxN8F'
    .reply 200, responseBody

  afterEach ->
    @room.destroy()
    nock.cleanAll()

  context 'user says spotify uri', ->
    link = 'spotify:track:2zvXUc9nn5Uwer8dbWxN8F'

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


  context 'user says spotify link', ->
    link = 'https://open.spotify.com/track/2zvXUc9nn5Uwer8dbWxN8F'

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

  context 'user says spotify open link', ->
    link = 'https://open.spotify.com/track/2zvXUc9nn5Uwer8dbWxN8F'

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

  context 'user says spotify play link', ->
    link = 'https://play.spotify.com/track/2zvXUc9nn5Uwer8dbWxN8F?ref=some_tracking_garbage'

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
