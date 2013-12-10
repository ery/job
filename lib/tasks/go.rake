
task :go_2 => :environment do
  Topic.all.each do |topic|
    puts "Topic........................................"
    puts "title: #{topic.title}"
    puts "status: #{topic.status}"
    next

    puts "url: #{topic.url}"
    puts "file: #{topic.file}"
    puts "analyzed_salary: #{topic.analyzed_salary}"
    puts "created_at: #{topic.created_at}"
    puts "updated_at: #{topic.updated_at}"
    puts "analyzed_author: #{topic.analyzed_author}"
    puts "manual_salary: #{topic.manual_salary}"
    puts "manual_memo: #{topic.manual_memo}"
    puts ""
  end
end

# task :go_1 => :environment do
#   Topic.all.each do |topic|
#     unless topic.title.include?('北京')
#       topic.status = Topic::Status::NONE
#       topic.save!
#     end
#   end
# end


# task :go_3 => :environment do
#   Topic.all.each do |topic|
#     topic = topic.topic
#     topic.status        = topic.status
#     topic.manual_salary = topic.manual_salary
#     topic.manual_memo   = topic.manual_memo
#     topic.save!
#   end
# end
