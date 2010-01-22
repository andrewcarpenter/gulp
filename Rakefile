# Rakefile
require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('gulp') do |p|
  p.description    = "Identify Statistically Improbable Phrases (SIPs)"
  p.url            = "http://github.com/andrewcarpenter/gulp"
  p.author         = "Andrew Carpenter"
  p.ignore_pattern = ["tmp/*"]
  p.runtime_dependencies = ['activesupport', 'tokyocabinet', 'nokogiri']
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
