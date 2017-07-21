require "json"

hrows = [
  { cols: [ {value: 'task'}, {value: 'team'}, {value: 'subject'}, {value: 'CDPMOE'}, {value: 'DeliveryDate'}, {value: 'status'} ] }
]

file = File.read(File.expand_path("../tasks.json", __FILE__))
data = JSON.parse(file)
items = data;

rows = [
  { cols: [ {value: 'ROOM-6605'}, {value: "API"}, {value: "Adagio Long Séjour"}, {value: "Unkown"}, {value: "10-Jul"}, {value: "Livré"} ]},
  { cols: [ {value: '73885'}, {value: "SitesM"}, {value: "[LoL] MAJ Mentions legales Footer"}, {value: "Cyrille Ecrabet"} , {value: "10-Jul"}, {value: "Livré"}]},
  { cols: [ {value: '5280'}, {value:"ROOM" }, {value: "LH-wording sur les distances de POI" }, {value:"Tovo A."}, {value: "10-Jul"}, {value: "Livré"}]},
  { cols: [ {value: '73845'}, {value: "SitesM"}, {value: "[LINK] FRONT : pages d'erreur"}, {value: "Sandrine Bernard"}, {value: "10-Jul"}, {value: "A livrer"} ]},
  { cols: [ {value: '73889'}, {value: "ROOM"}, {value: "service à la carte - Lot 2"}, {value: "Fatima S."}, {value: "10-Jul"}, {value: "A livrer"}]},
  { cols: [ {value: 'ROOM-6605'}, {value: "API"}, {value: "Adagio Long Séjour"}, {value: "Unkown"}, {value: "10-Jul"}, {value: "Livré"} ]},
  { cols: [ {value: '73885'}, {value: "SitesM"}, {value: "[LoL] MAJ Mentions legales Footer"}, {value: "Cyrille Ecrabet"} , {value: "10-Jul"}, {value: "Livré"}]},
  { cols: [ {value: '5280'}, {value:"ROOM" }, {value: "LH-wording sur les distances de POI" }, {value:"Tovo A."}, {value: "10-Jul"}, {value: "Livré"}]}

]

SCHEDULER.every '10s' do

send_event('tasksTable', { hrows: hrows, rows: rows } )

end
