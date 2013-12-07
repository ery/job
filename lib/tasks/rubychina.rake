require 'open-uri'

namespace :rubychina do

  desc "Fetch job topics"
  task :fetch_job_topics => :environment do
    $topic_list     = []
    $new_topic_list = []

    page_count = 3
    page_count.times.each do |index|
      page_number = index + 1
      page_url    = "http://ruby-china.org/topics/node25?page=#{page_number}"
      sleep 1
      puts "Fetch topics from #{page_url}"
      fetch_topics_form_page page_url
      puts " "
    end

    puts_new_topics
  end

  def fetch_topics_form_page(page_url)
    doc = Nokogiri::HTML(open(page_url))
    doc.css('.topic_line').each do |line|
      topic = {}
      topic[:title]      = line.css('.title a').first.content
      topic[:url]        = rubychina_url(line.css('.title a').first[:href])
      topic[:author]     = line.css('.info a').first.content
      topic[:author_url] = rubychina_url(line.css('.info a').first[:href])
      topic[:orginal_id] = topic[:url].sub("http://ruby-china.org/topics/", "")
      topic[:local_file] = "#{topic_folder}/#{topic[:orginal_id]}.html"

      fetch_topic topic
    end
  end

  def fetch_topic(topic)
    print "."

    $topic_list << topic

    if RubychinaTopic.where(url: topic[:url]).exists?
      return
    end

    page = open(topic[:url]).read
    IO.write topic[:local_file], page

    RubychinaTopic.create! topic

    $new_topic_list << topic
  end

  def topic_folder
    path = File.expand_path("../../../db/rubychina", __FILE__)
    unless File.directory?(path)
      Dir.mkdir path
    end
    return path
  end

  def puts_new_topics
    puts "fetch #{$topic_list.count} job topics, #{$new_topic_list.count} new topics."
    $new_topic_list.each do |topic|
      puts "Topic..........................................."
      puts "Title:      #{topic[:title]}"
      puts "URL:        #{topic[:url]}"
      puts "Author:     #{topic[:author]}"
      puts "Author URL: #{topic[:author_url]}"
      puts "File:       #{topic[:file]}"
      puts
    end
  end

  def rubychina_url(url)
    "http://ruby-china.org#{url}"
  end

end