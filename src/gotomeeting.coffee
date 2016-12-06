request = require 'request'

class GotoMeeting

  constructor: ({accessToken}) ->
    @options = {
      baseUrl: "https://api.citrixonline.com/G2M/rest"
      headers:
        Authorization: accessToken
    }

  api: (method, path, qs, body, callback) =>
    @options.method = method
    @options.qs = qs if qs?
    @options.body = body if body?
    @options.uri = path

    request @options, callback

module.exports = GotoMeeting
