require 'open-uri'

namespace :topic do

  desc "Analyze"
  task :analyze => :environment do
    Topic.all.each do |topic|
      print "."

      next unless topic.title.include?("北京")
      create_subject topic
      analyze_topic topic
    end
    puts "."
  end

  def create_subject(topic)
    if Subject.where(:url => topic.url).exists?
      return
    end

    Subject.create!({
      :title  => topic.title,
      :url    => topic.url,
      :status => Subject::Status::INBOX
      })
  end

  def analyze_topic(topic)
    subject = Subject.find_by_url!(topic.url)

    salary = analyze_salary(topic)

    subject.salary = salary
    subject.save!
  end

  def analyze_salary(topic)
    doc = Nokogiri::HTML(open(topic.file))
    description = doc.css('.topic .body').first.content
    description.gsub!("\n", ' ')

    salary = /薪.{1,50}/.match(description)

    return salary.to_s
  end

end
