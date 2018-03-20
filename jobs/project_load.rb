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

SCHEDULER.every '25s', :first_in => 0 do |job|
  i = 2
  loop do

    i_string = i.to_s
    range = 'A' + i_string + ':F' + i_string    # DEFINE YOUR OWN RANGE HERE
    response = sheet.get_spreadsheet_values(SPREADSHEET_ID, range, value_render_option: render_option)
    project = JSON.parse(response.to_json)
    puts '¨¨¨¨¨¨¨¨¨¨¨¨Read The Data From the Shared Excel File¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨'
    puts project

    if !project.key?("values")
      break
    end

    project_values   = project["values"][0]
    # MATCH THE FOLLOWING VARIABLES WITH YOUR OWN COLUMNS
    project_id       = project_values[0]
    project_logo_url = project_values[1].split('"')[1]
    project_name     = project_values[2]
    project_critical = project_values[3]
    project_major    = project_values[4]
    project_minor    = project_values[5]
    send_event("project-id", project_logo_url: project_logo_url, project_name: project_name, project_critical: project_critical, project_major: project_major, project_minor: project_minor)
    i += 1
  end
end
