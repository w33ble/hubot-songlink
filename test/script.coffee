HubotHelper = require 'hubot-test-helper'
{ expect } = require 'chai'
nock = require 'nock'

helper = new HubotHelper('../index.coffee')
responseBody =
  title: 'Nobody Speak (feat. Run the Jewels)'
  artist: 'DJ Shadow'
  album_title: 'Nobody Speak (feat. Run the Jewels)'
  album_art: 'https://i.scdn.co/image/500cf6ba4e1b37bcded0517359882036f4a34a35'
  source_id: '2zvXUc9nn5Uwer8dbWxN8F'
  source: 'spotify'
  share_link: 'http://songl.ink/d49d6'

checkBotResponse = (messages) ->
  expect(messages).to.have.lengthOf 2
  expect(messages[1]).to.eql [
    'hubot'
    "#{responseBody.artist} - #{responseBody.title} | #{responseBody.share_link}"
  ]

checkNoBotResponse = (messages) ->
  expect(messages).to.have.lengthOf 1

describe 'listening and replying', ->
  beforeEach ->
    @room = helper.createRoom()
    nock.disableNetConnect()

    nock('http://www.songl.ink')
    .post '/create', (body) ->
      itunes = (body.source is 'itunes' && body.id is '1100742531')
      spotify = (body.source is 'spotify' && body.id is '2zvXUc9nn5Uwer8dbWxN8F')
      return itunes or spotify
    .reply 200, responseBody

  afterEach ->
    @room.destroy()
    nock.cleanAll()

  context 'user says itunes url', ->
    it 'should respond if just a link', ->
      @room.user.say('alice', 'https://itun.es/us/18_Mbb?i=1100742531')
      .then => checkBotResponse @room.messages

    it 'should respond if link at end', ->
      @room.user.say('alice', 'OMG!!! YOU GUIZ!!!!!! https://itun.es/us/18_Mbb?i=1100742531')
      .then => checkBotResponse @room.messages

    it 'should respond if link at begining', ->
      @room.user.say('alice', 'https://itun.es/us/18_Mbb?i=1100742531 <3 <3 <3')
      .then => checkBotResponse @room.messages

    it 'should respond if link in text', ->
      @room.user.say('alice', 'i am crushing on https://itun.es/us/18_Mbb?i=1100742531 right now')
      .then => checkBotResponse @room.messages
