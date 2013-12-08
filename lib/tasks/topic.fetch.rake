require 'open-uri'

namespace :topic do

  desc "Fetch"
  task :fetch => :environment do
    $topic_list = []
    $download_new_topic_list = []
    $create_new_topic_list   = []

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
      topic = {}
      topic[:title]      = line.css('.title a').first.content
      topic[:url]        = rubychina_url(line.css('.title a').first[:href])
      topic[:author]     = line.css('.info a').first.content
      topic[:author_url] = rubychina_url(line.css('.info a').first[:href])
      topic[:orginal_id] = topic[:url].sub("http://ruby-china.org/topics/", "")
      topic[:local_file] = "#{topic_folder}/#{topic[:orginal_id]}.html"

      print "."
      $topic_list << topic

      download_topic topic

      create_topic topic
    end
  end

  def download_topic(topic)
    if File.exists?(topic[:local_file])
      return
    end

    page = open(topic[:url]).read
    IO.write topic[:local_file], page

    $download_new_topic_list << topic
  end

  def create_topic(topic)
    if Topic.where(url: topic[:url]).exists?
      return
    end

    Topic.create! topic

    $create_new_topic_list << topic
  end

  def topic_folder
    path = File.expand_path("../../../db/topics", __FILE__)
    unless File.directory?(path)
      Dir.mkdir path
    end
    return path
  end

  def puts_report
    $create_new_topic_list.each do |topic|
      puts "Topic..........................................."
      puts "Title:      #{topic[:title]}"
      puts "URL:        #{topic[:url]}"
      puts "Author:     #{topic[:author]}"
      puts "Author URL: #{topic[:author_url]}"
      puts "File:       #{topic[:file]}"
      puts
    end

    puts "Fetch #{$topic_list.count} topics."
    puts "Download #{$download_new_topic_list.count} topics."
    puts "Create #{$create_new_topic_list.count} topics."
  end

  def rubychina_url(url)
    "http://ruby-china.org#{url}"
  end

end