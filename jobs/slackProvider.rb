require 'net/http'
require 'json'


SCHEDULER.every '20s' do
  # check if our API-Key is present
  # if ENV["SLACK_TOKEN"] == nil
  if settings.slack["token"] == nil
    send_event('RootFrame', { errormsg: "No API-Key specified!" })
  else
    # Dashing-status channel
    uri = URI("https://slack.com/api/channels.history?token="+ settings.slack["token"] +"&channel="+settings.slack["channel-status"]+"&count=1&pretty=1")
    Net::HTTP.get(uri)
    res = Net::HTTP.get_response(uri)
    slack = JSON.parse(res.body)

    messages = Hash.new
    # check if slack API sent us valid information
    if slack["ok"] != true
      send_event('RootFrame', { errormsg: "#{slack['error']}" })
    else
      # parse the information slack gave us
      slack['messages'].each{ |mem|
        messages["#{mem['id']}"] = { text: "#{mem['text']}" }
      }
      send_event('RootFrame', { items: messages.values })

    end

    # dashing-alerts channel
    urii = URI("https://slack.com/api/channels.history?token="+ settings.slack["token"] +"&channel="+settings.slack['channel-alert']+"&count=1&pretty=1")
    Net::HTTP.get(urii)
    ress = Net::HTTP.get_response(urii)
    slackk = JSON.parse(ress.body)

    messagess = Hash.new
    # check if slack API sent us valid information
    if slackk["ok"] != true
      send_event('tasksTable', { errormsg: "#{slackk['error']}" })
    else
      # parse the information slack gave us
      slackk['messages'].each{ |memm|
        messagess["#{memm['id']}"] = { text: "#{memm['text']}" }
      }
      send_event('tasksTable', { itemss: messagess.values })

    end

  end
end
