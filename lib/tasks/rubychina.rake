require 'open-uri'

namespace :rubychina do

  desc 'Fetch job'
  task :fetch_job => :environment do
    $topic_list     = []
    $new_topic_list = []

    page_count = 40
    page_count.times.each do |index|
      page_number = index + 1
      page_url    = "http://ruby-china.org/topics/node25?page=#{page_number}"
      sleep 1
      puts "Fetch Page #{page_url}"
      fetch_topic page_url
      puts " "
    end

    puts "Fetch #{$topic_list.count} job topics, #{$new_topic_list.count} new topics."
    $new_topic_list.each do |topic|
      puts_topic topic
    end
  end

  def fetch_topic(page_url)
    doc = Nokogiri::HTML(open(page_url))
    doc.css('.topic_line').each do |line|
      topic = {}
      topic[:title]      = line.css('.title a').first.content
      topic[:url]        = line.css('.title a').first[:href]
      topic[:author]     = line.css('.info a').first.content
      topic[:author_url] = line.css('.info a').first[:href]

      topic[:url]        = rubychina_url(topic[:url])
      topic[:author_url] = rubychina_url(topic[:author_url])

      save_topic topic
    end
  end

  def save_topic(topic)
    unless topic[:title].include?('北京')
      return
    end

    print "."

    $topic_list << topic

    if Topic.where(url: topic[:url]).exists?
      return
    end
    Topic.create!(title: topic[:title], url: topic[:url])

    $new_topic_list << topic
  end

  def puts_topic(topic)
    puts "Topic..........................................."
    puts "Title:      #{topic[:title]}"
    puts "URL:        #{topic[:url]}"
    puts "Author:     #{topic[:author]}"
    puts "Author URL: #{topic[:author_url]}"
    puts
  end

  def rubychina_url(url)
    "http://ruby-china.org#{url}"
  end

end