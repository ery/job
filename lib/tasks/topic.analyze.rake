require 'open-uri'

namespace :topic do

  desc "Analyze"
  task :analyze => :environment do
    Subject.delete_all

    Topic.all.each do |topic|
      print "."
      analyze_topic topic
    end
    puts "."
  end

  def analyze_topic(topic)
    unless topic.title.include?("北京")
      return
    end

    annual_salary = analyze_salary(topic)

    Subject.create!({
      :title => topic.title,
      :url => topic.url,
      :annual_salary => annual_salary,
      :status => Subject::Status::INBOX
      })
  end

  def analyze_salary(topic)
    doc = Nokogiri::HTML(open(topic.file))
    description = doc.css('.topic .body').first.content
    description.gsub!("\n", ' ')

    salary = /薪.{1,50}/.match(description)

    return salary.to_s
  end

end
