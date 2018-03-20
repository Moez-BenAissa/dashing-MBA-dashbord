require "json"

buzzwords = ['Paradigm shift', 'Leverage', 'Pivoting', 'Turn-key', 'Streamlininess', 'Exit strategy', 'Synergy', 'Enterprise', 'Web 2.0']
buzzword_counts = Hash.new({ value: 0 })


  file = File.read(File.expand_path("../../assets/data/tasks.json", __FILE__))
  data = JSON.parse(file)

  items = data;

SCHEDULER.every '2s' do
  random_buzzword = buzzwords.sample
  buzzword_counts[random_buzzword] = { label: random_buzzword, value: (buzzword_counts[random_buzzword][:value] + 1) % 30 }

  send_event('Tasks', { items: items })
end
