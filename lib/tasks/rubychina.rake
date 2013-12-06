require 'open-uri'

namespace :rubychina do

  desc 'Fetch Job'
  task :fetch_job do
    doc = Nokogiri::HTML(open("http://ruby-china.org/topics/node25"))
    doc.css('.topic_line').each do |line|
      title = line.css('.title a').first
      info = line.css('.info a').first
      puts [title.content, title[:href]].join
      puts [info.content, info[:href]].join
    end
  end

end