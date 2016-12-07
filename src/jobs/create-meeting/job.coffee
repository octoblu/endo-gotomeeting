http   = require 'http'
_      = require 'lodash'
GotoMeeting = require '../../gotomeeting.coffee'

class CreateMeeting
  constructor: ({@encrypted}) ->
    @gotomeeting = new GotoMeeting {accessToken: @encrypted.secrets.credentials.secret}

  do: ({data}, callback) =>
    return callback @_userError(422, 'data.subject is required') unless data.subject?
    return callback @_userError(422, 'data.conferencecallinfo is required') unless data.conferencecallinfo?
    return callback @_userError(422, 'data.starttime is required') unless data.starttime?
    return callback @_userError(422, 'data.endtime is required') unless data.endtime?

    @gotomeeting.api('POST', '/meetings', null, data, (error, response, body) =>
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

module.exports = CreateMeeting
