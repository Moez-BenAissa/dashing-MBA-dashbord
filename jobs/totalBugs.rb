# current_CriticalBugs = 14
# moreInfo = "Critical status"
# differenceRate = -10
#
# SCHEDULER.every '1s' do
#   last_CriticalBugs     = current_CriticalBugs
#   send_event('CriticalBugs', { current: current_CriticalBugs, last: last_CriticalBugs, moreinfo: moreInfo, difference:differenceRate })
# end

SCHEDULER.every '1s' do

  send_event('TotalBugs', { current: 85, last: 70, moreinfo: "Normal status"})
end
