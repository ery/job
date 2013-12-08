
desc "Step 2 create subject"
task :step_2_create_subject => :environment do
  puts "Step 2 create subject"
  Topic.all.each do |topic|
    print "."
    create_subject topic
  end
  puts "."
end

def create_subject(topic)
  unless topic.title.include?("北京")
    return
  end

  if Subject.where(:url => topic.url).exists?
    return
  end

  Subject.create!({
    :title  => topic.title,
    :url    => topic.url,
    :status => Subject::Status::INBOX
    })
end
