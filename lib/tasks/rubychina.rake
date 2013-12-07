require 'open-uri'

namespace :rubychina do

  desc "Fetch job topics"
  task :fetch_job_topics => :environment do
    $topic_list     = []
    $new_topic_list = []

    page_count = 40
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
      topic[:url]        = line.css('.title a').first[:href]
      topic[:author]     = line.css('.info a').first.content
      topic[:author_url] = line.css('.info a').first[:href]

      topic[:url]        = rubychina_url(topic[:url])
      topic[:author_url] = rubychina_url(topic[:author_url])

      fetch_topic topic, doc
    end
  end

  def fetch_topic(topic, doc)
    print "."

    $topic_list << topic

    #if RubyChinaTopic.where(url: topic[:url]).exists?
    #  return
    #end

    topic[:file] = File.expand_path("../../../db/rubychina/#{1,rand(999999)}.html", __FILE__)
    File.open(topic[:file], 'w') { |file| file.write(doc.to_s) }
    #RubyChinaTopic.create!(title: topic[:title], url: topic[:url], file: topic[:file])

    $new_topic_list << topic
  end

  def puts_new_topics(topic)
    puts "fetch #{$topic_list.count} job topics, #{$new_topic_list.count} new topics."
    $new_topic_list.each do |topic|
      puts_topic topic

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