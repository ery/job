require 'open-uri'

namespace :topic do

  desc "Fetch"
  task :fetch => :environment do
    $found_topics    = []
    $download_topics = []
    $created_topics  = []

    page_count = 40
    page_count.times.each do |index|
      page_number = index + 1
      page_url    = "http://ruby-china.org/topics/node25?page=#{page_number}"
      sleep 1
      puts "Fetch topics from #{page_url}"
      fetch_topics_from_page page_url
      puts " "
    end

    puts_report
  end

  def fetch_topics_from_page(page_url)
    doc = Nokogiri::HTML(open(page_url))
    doc.css('.topic_line').each do |line|
      title        = line.css('.title a').first.content
      url          = line.css('.title a').first[:href]
      rubychina_id = line.css('.title a').first[:href].sub("topics/", "")

      topic = {}
      topic[:title] = title
      topic[:url]   = "http://ruby-china.org#{url}"
      topic[:file]  = "#{topic_folder}/#{rubychina_id}.html"

      print "."
      $found_topics << topic

      download_topic topic

      create_topic topic
    end
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

    Topic.create! topic

    $created_topics << topic
  end

  def topic_folder
    path = File.expand_path("../../../db/topics", __FILE__)
    unless File.directory?(path)
      Dir.mkdir path
    end
    return path
  end

  def puts_report
    $created_topics.each do |topic|
      puts "Create a topic..........................................."
      puts "Title: #{topic[:title]}"
      puts "URL:   #{topic[:url]}"
      puts "File:  #{topic[:file]}"
      puts
    end

    puts "Fetch topics:"
    puts "Found #{$found_topics.count}."
    puts "Download #{$download_topics.count}."
    puts "Created #{$created_topics.count}."
  end

  def rubychina_url(url)
  end

end