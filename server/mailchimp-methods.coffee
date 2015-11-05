Meteor.methods

  fetchListCount: (list_id) ->
    url = "https://us3.api.mailchimp.com/3.0/lists/#{list_id}"
    opts = { 
      headers: { 
        Authorization: process.env.MAILCHIMP_AUTH_STRING 
      }
    }

    result = Meteor.http.get(url, opts)
    if result.statusCode is 200
      return JSON.parse result.data.stats.member_count
    else
      errorJson = JSON.parse(result.content)
      throw new Meteor.Error(result.statusCode, errorJson.error)