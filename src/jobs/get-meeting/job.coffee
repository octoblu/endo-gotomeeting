http   = require 'http'
_      = require 'lodash'
GotoMeeting = require '../../gotomeeting.coffee'

class GetMeeting
  constructor: ({@encrypted}) ->
    @gotomeeting = new GotoMeeting {accessToken: @encrypted.secrets.credentials.secret}

  do: ({data}, callback) =>
    return callback @_userError(422, 'data.meetingId is required') unless data.meetingId?

    @gotomeeting.api('GET', "/meetings/#{data.meetingId}", null, null, (error, response, body) =>
      return callback @_userError(422, error) if error
      return callback null, {
        metadata:
          code: 200
          status: http.STATUS_CODES[200]
        data: body
      }
    )

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = GetMeeting
