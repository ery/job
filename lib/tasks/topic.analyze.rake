require 'open-uri'

namespace :topic do

  desc "Analyze"
  task :analyze => :environment do
    Topic.all.each do |topic|
      print "."
      analyze_topic topic
    end
  end

  def analyze_topic(topic)
    unless topic.title.include?("北京")
      return
    end

    if Subject.where(url: topic.url).exists?
      return
    end

    Subject.create!({
      :title => topic.title,
      :url => topic.url,
      :status => Subject::Status::INBOX
      })
  end

end
