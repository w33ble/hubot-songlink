# Description:
#   generates songl.ink links from song urls
#
# Commands:
#   <itunes/spotify link> - Outputs songl.ink URL
#
# Notes:
#   Reponses from the songl.ink API look like this:
#   {
#     title: "Nobody Speak (feat. Run the Jewels)"
#     artist: "DJ Shadow"
#     album_title: "Nobody Speak (feat. Run the Jewels)"
#     album_art: "https://i.scdn.co/image/500cf6ba4e1b37bcded0517359882036f4a34a35"
#     source_id: "2zvXUc9nn5Uwer8dbWxN8F"
#     source: "spotify"
#     share_link: "http://songl.ink/d49d6"
#   }
#
# Author:
#   w33ble

linkMatches =
  itunesTrackLink:
    type: 'itunes'
    match: /https:\/\/itun.es\/[a-z]+\/[\w-]+\?i=([\d]+)/
  spotifyTrackLink:
    type: 'spotify'
    match: /https:\/\/open.spotify.com\/[\w]+\/([\w\d]+)/
  spotifyPlayLink:
    type: 'spotify'
    match: /https:\/\/play.spotify.com\/[\w]+\/([\w\d]+)?(.*)/
  spotifyUri:
    type: 'spotify'
    match: /spotify:track:([\w\d-]+)/

apiUrl = 'http://www.songl.ink/create'

module.exports = (robot) ->
  for name, meta of linkMatches
    do (name, meta) ->
      robot.hear meta.match, (msg) ->
        robot.logger.info "Found #{name} link (#{meta.type})"

        payload =
          source: meta.type
          id: msg.match[1]

        robot.http(apiUrl).post(JSON.stringify(payload)) (err, res, body) ->
          try
            if err || res.statusCode >= 400
              robot.logger.error err
              return

            data = JSON.parse body

            msg.send "#{data.artist} - #{data.title} | #{data.share_link}"
          catch e
            robot.logger.error e

