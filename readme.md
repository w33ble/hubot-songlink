# hubot-songlink

[![Build Status](https://travis-ci.org/w33ble/hubot-songlink.svg?branch=master)](https://travis-ci.org/w33ble/hubot-songlink)

A [hubot](https://hubot.github.com) script for generating [songl.ink](http://www.songl.ink/) links from song urls

## Installation

In hubot project repo, run:

`npm install hubot-songlink --save`

Then add **hubot-songlink** to your `external-scripts.json`:

```json
[
  "hubot-songlink"
]
```

## Sample Interaction

```
user1>> check this out! https://open.spotify.com/track/2zvXUc9nn5Uwer8dbWxN8F
hubot>> DJ Shadow - Nobody Speak (feat. Run the Jewels) | http://songl.ink/d49d6
```