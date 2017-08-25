
$: << File.expand_path('./lib', File.dirname(__FILE__))
require "sinatra/cyclist"
require 'dashing'
require 'dashing-contrib'
DashingContrib.configure


configure do
  set :auth_token, 'MBAToken'
  set :jenkins, {
    'url'  => 'http://localhost:8080',
    'view' => 'All'
  }

  set :spread, {
    'client_id' => '678415161385-20hrvs95hplufi9pd05dhmu8bl416p8f.apps.googleusercontent.com',
    'client_secret' =>'wupcz1oIIy0RBtLmOjOvvhaz',
    'refresh_token' =>'',
    'document_id' =>'1QvZWKk2r2Du68daXTsboSad3EO1aNqJRYOAKiDJByLM'
  }

  set :slack, {
    'token'  => 'xoxp-52237316115-52292056049-217319962692-5bf486eae32863c931e26e06328bb6d4',
    'channel-alert' => 'C6DFBADB7',
    'channel-status' => 'C6E8857V4'
  }

  helpers do
    def protected!
      # Put any authentication code you want in here.
      # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

set :routes_to_cycle_through, [:MBADashboard, :jenkins, :MBADashboardTV]

run Sinatra::Application
