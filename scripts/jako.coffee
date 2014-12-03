# Description:
#   Translation bot of Japanese-Korean
#
# Commands:
#   Enter text that you want translate

# Hubotのスクリプトはモジュールとして記述し，
# Hubot起動時にrequireされてexportした関数が呼び出されます

japanese = ///
[あ-んア-ン]
///

korean = ///
[가-힣]
///

translate = (msg, origin, target) ->
    msg.http("https://translate.google.com/translate_a/t")
        .query({
            client: 't'
            hl: 'en'
            multires: 1
            sc: 1
            sl: origin
            ssel: 0
            tl: target
            tsel: 0
            uptl: 'en'
            text: msg.message.text
        })
        .header('User-Agent', 'Mozilla/5.0')
        .get() (err, res, body) ->
            data   = body
            if data.length > 4 and data[0] == '['
                parsed = eval(data)
                parsed = parsed[0] and parsed[0][0] and parsed[0][0][0]
                if parsed
                    msg.send "#{parsed}"

module.exports = (robot) ->
    robot.hear japanese, (msg) ->
        translate msg, 'ja', 'ko'

    robot.hear korean, (msg) ->
        translate msg, 'ko', 'ja'
