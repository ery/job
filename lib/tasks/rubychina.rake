require 'open-uri'

namespace :rubychina do

  desc 'Fetch Job'
  task :fetch_job => :environment do
    page_count = 40
    page_count.times.each do |index|
      page_number = index + 1
      page_url    = "http://ruby-china.org/topics/node25?page=#{page_number}"
      sleep 1
      fetch_job_from_page page_url
    end

    puts "Fetch #{$job_list.count} jbos."
  end

  def fetch_job_from_page(page_url)
    doc = Nokogiri::HTML(open(page_url))
    doc.css('.topic_line').each do |line|
      job = {}
      job[:topic_title] = line.css('.title a').first.content
      job[:topic_url]   = line.css('.title a').first[:href]
      job[:author]      = line.css('.info a').first.content
      job[:author_url]  = line.css('.info a').first[:href]

      job[:topic_url]   = rubychina_url(job[:topic_url])
      job[:author_url]  = rubychina_url(job[:author_url])

      save_job job
    end
  end

  def save_job(job)
    unless job[:topic_title].include?('北京')
      return
    end

    $job_list ||= []
    $job_list << job

    if Topic.where(url: job[:topic_url]).exists?
      return
    end
    Topic.create!(title: job[:title], url: job[:topic_url])
    puts_job job
  end

  def puts_job(job)
    puts "Topic Title: #{job[:topic_title]}"
    puts "Topic URL:   #{job[:topic_url]}"
    puts "Author:      #{job[:author]}"
    puts "Author URL:  #{job[:author_url]}"
    puts
  end

  def rubychina_url(url)
    "http://ruby-china.org#{url}"
  end

end