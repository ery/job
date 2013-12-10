
task :go_3 => :environment do
  Topic.all.each do |topic|
    puts "."
    tag = get_status_tag(topic)
    TopicTag.create! :topic_id => topic.id, :tag_id => tag.id
  end
end

def get_status_tag(topic)
  status = topic.status
  tag = Tag.find_by_name(status)
  unless tag
    tag = Tag.create!(:name => status)
  end
  return tag
end

task :go_2 => :environment do
  Topic.all.each do |topic|
    puts "title: #{topic.title}"
    next
    puts "Topic........................................"
    puts "status: #{topic.status}"

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
