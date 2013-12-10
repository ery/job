# desc "Go go go."
# task :gogogo => :environment do
#   Topic.all.each do |topic|
#     unless topic.title.include?('北京')
#       topic.status = Subject::Status::OTHER
#       topic.save!
#     end
#   end
# end

desc "Go go go."
task :gogogo => :environment do
  Topic.all.each do |topic|
    puts "Topic........................................"
    puts "title: #{topic.title}"
    # puts "url: #{topic.url}"
    # puts "file: #{topic.file}"
    # puts "analyzed_salary: #{topic.analyzed_salary}"
    # puts "created_at: #{topic.created_at}"
    # puts "updated_at: #{topic.updated_at}"
    # puts "analyzed_author: #{topic.analyzed_author}"
    puts "status: #{topic.status}"
    # puts "manual_salary: #{topic.manual_salary}"
    # puts "manual_memo: #{topic.manual_memo}"
    puts ""
  end
end

# task :move_subject_to_topic => :environment do
#   Subject.all.each do |subject|
#     topic = subject.topic
#     topic.status        = subject.status
#     topic.manual_salary = subject.manual_salary
#     topic.manual_memo   = subject.manual_memo
#     topic.save!
#   end
# end
