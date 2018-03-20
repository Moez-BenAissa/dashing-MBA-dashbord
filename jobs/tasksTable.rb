require 'googleauth'
require 'google/apis/sheets_v4'
require 'json'

#client_id = settings.spread["client_id"]
# client_secret = settings.spread["client_secret"]
# refresh_token = settings.spread["refresh_token"]
# doc_id = settings.spread["document_id"]

APPLICATION_NAME = 'ProjectLoad Widget'
SPREADSHEET_ID = '1QvZWKk2r2Du68daXTsboSad3EO1aNqJRYOAKiDJByLM'

sheet = Google::Apis::SheetsV4::SheetsService.new
sheet.client_options.application_name = APPLICATION_NAME

# Get the environment configured authorization
scopes =  [
      'https://www.googleapis.com/auth/spreadsheets.readonly'
    ]
authorization = Google::Auth.get_application_default(scopes)
sheet.authorization = authorization
render_option = 'FORMULA'

hrows = [
  { cols: [ {value: 'subject'}, {value: 'status'}, {value: 'DeliveryDate'} ] } 
  # { cols: [ {value: 'CQ/Jira'}, {value: 'team'}, {value: 'subject'}, {value: 'status'}, {value: 'CDP/MOE'}, {value: 'DeliveryDate'} ] }
]
rows = []
SCHEDULER.every '25s', :first_in => 0 do |job|
  i = 10
  loop do

    i_string = i.to_s
    range = 'A' + i_string + ':F' + i_string
    response = sheet.get_spreadsheet_values(SPREADSHEET_ID, range, value_render_option: render_option)
    project = JSON.parse(response.to_json)
    rows[i-10] = project
    if !project.key?("values")
      break
    end
    i += 1
  end
  puts rows
  send_event('tasksTable', { hrows: hrows, rows: rows } )
end


# hrows = [
#   { cols: [ {value: 'task'}, {value: 'team'}, {value: 'subject'}, {value: 'CDPMOE'}, {value: 'DeliveryDate'}, {value: 'status'} ] }
# ]
#
# file = File.read(File.expand_path("../../assets/data/tasks.json", __FILE__))
# data = JSON.parse(file)
# items = data;
#
# {"range"=>"'Feuille 1'!A10:F10", "majorDimension"=>"ROWS", "values"=>[["ROOM-6605", "API", "Adagio Long Séjour", "Unkown", "10-Jul", "Livré"]]}
# {"range"=>"'Feuille 1'!A11:F11", "majorDimension"=>"ROWS", "values"=>[[73885, "SitesM", "[LoL] MAJ Mentions legales Footer", "Cyrille Ecrabet", "10-Jul", "Livré"]]}
# {"range"=>"'Feuille 1'!A12:F12", "majorDimension"=>"ROWS", "values"=>[[5280, "ROOM", "LH-wording sur les distances de POI", "Tovo A.", "10-Jul", "Livré"]]}
# {"range"=>"'Feuille 1'!A13:F13", "majorDimension"=>"ROWS", "values"=>[[73845, "SitesM", "[LINK] FRONT : pages d'erreu", "Sandrine Bernard", "10-Jul", "Livré"]]}
# {"range"=>"'Feuille 1'!A14:F14", "majorDimension"=>"ROWS", "values"=>[[73889, "ROOM", "service à la carte - Lot 2", "Fatima S.", "10-Jul", "A livrer"]]}
# {"range"=>"'Feuille 1'!A15:F15", "majorDimension"=>"ROWS", "values"=>[["ROOM-6605", "API", "Adagio Long Séjour", "Unkown", "10-Jul", "A livrer"]]}
# {"range"=>"'Feuille 1'!A16:F16", "majorDimension"=>"ROWS", "values"=>[[73885, "SitesM", "[LoL] MAJ Mentions legales Footer", "Cyrille Ecrabet", "10-Jul", "A livrer"]]}
# {"range"=>"'Feuille 1'!A17:F17", "majorDimension"=>"ROWS", "values"=>[[5280, "ROOM", "LH-wording sur les distances de POI", "Tovo A.", "10-Jul", "A livrer"]]}
# {"range"=>"'Feuille 1'!A18:F18", "majorDimension"=>"ROWS"}
# rows = [
#   { cols: [ {value: 'ROOM-6605'}, {value: "API"}, {value: "Adagio Long Séjour"}, {value: "Unkown"}, {value: "10-Jul"}, {value: "Livré"} ]},
#   { cols: [ {value: '73885'}, {value: "SitesM"}, {value: "[LoL] MAJ Mentions legales Footer"}, {value: "Cyrille Ecrabet"} , {value: "10-Jul"}, {value: "Livré"}]},
#   { cols: [ {value: '5280'}, {value:"ROOM" }, {value: "LH-wording sur les distances de POI" }, {value:"Tovo A."}, {value: "10-Jul"}, {value: "Livré"}]},
#   { cols: [ {value: '73845'}, {value: "SitesM"}, {value: "[LINK] FRONT : pages d'erreur"}, {value: "Sandrine Bernard"}, {value: "10-Jul"}, {value: "A livrer"} ]},
#   { cols: [ {value: '73889'}, {value: "ROOM"}, {value: "service à la carte - Lot 2"}, {value: "Fatima S."}, {value: "10-Jul"}, {value: "A livrer"}]},
#   { cols: [ {value: 'ROOM-6605'}, {value: "API"}, {value: "Adagio Long Séjour"}, {value: "Unkown"}, {value: "10-Jul"}, {value: "Livré"} ]},
#   { cols: [ {value: '73885'}, {value: "SitesM"}, {value: "[LoL] MAJ Mentions legales Footer"}, {value: "Cyrille Ecrabet"} , {value: "10-Jul"}, {value: "Livré"}]},
#   { cols: [ {value: '5280'}, {value:"ROOM" }, {value: "LH-wording sur les distances de POI" }, {value:"Tovo A."}, {value: "10-Jul"}, {value: "Livré"}]}
#
# ]

# SCHEDULER.every '10s' do
#
# send_event('tasksTable', { hrows: hrows, rows: rows } )
#
# end
