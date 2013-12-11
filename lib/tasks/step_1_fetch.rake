require 'open-uri'

desc "Step 1 fetch: find, download, create topics."
task :step_1_fetch => :environment do
  puts "Step 1 fetch: find, download, create topics."
  $find_topics    = []
  $download_topics = []
  $create_topics  = []

  page_count = 40
  page_count.times.each do |index|
    page_number = index + 1
    page_url    = "http://ruby-china.org/topics/node25?page=#{page_number}"
    sleep 1
    puts "Fetch from #{page_url}"
    fetch_topic page_url
    puts " "
  end

  puts_report
end

def fetch_topic(page_url)
  doc = Nokogiri::HTML(open(page_url))
  doc.css('.topic_line').each do |line|
    print "."
    topic = find_topic(line)
    download_topic topic
    create_topic topic
  end
end

def find_topic(line)
  title        = line.css('.title a').first.content
  url          = line.css('.title a').first[:href]
  rubychina_id = line.css('.title a').first[:href].sub("topics/", "")

  topic = {}
  topic[:title] = title
  topic[:url]   = "http://ruby-china.org#{url}"
  topic[:file]  = "#{topic_folder}/#{rubychina_id}.html"

  $find_topics << topic

  return topic
end

def download_topic(topic)
  if File.exists?(topic[:file])
    return
  end

  page = open(topic[:url]).read
  IO.write topic[:file], page

  $download_topics << topic
end

def create_topic(topic)
  if Topic.where(url: topic[:url]).exists?
    return
  end

  if topic[:title].include?("北京")
    topic.add_tag Tag::INBOX
  else
    topic.add_tag Tag::OTHER
  end

  Topic.create! topic

  $create_topics << topic
end

def topic_folder
  path = File.expand_path("../../../db/topics", __FILE__)
  unless File.directory?(path)
    Dir.mkdir path
  end
  return path
end

def puts_report
  $create_topics.each do |topic|
    puts "Create a topic..........................................."
    puts "Title: #{topic[:title]}"
    puts "URL:   #{topic[:url]}"
    puts "File:  #{topic[:file]}"
    puts
  end

  puts "Fetch topics:"
  puts "Find #{$find_topics.count}."
  puts "Download #{$download_topics.count}."
  puts "Create #{$create_topics.count}."
end
