
task :go_6_remove_topic_tag => :environment do
  TopicTag.delete_all()
end

task :go_5_check => :environment do
  list = {}
  TopicTag.all.each do |item|
    if item.tag == nil
      puts item.topic.title
    end
  end
end

task :go_4_check => :environment do
  list = {}
  TopicTag.all.each do |item|
    key = "#{item.topic_id}_#{item.tag_id}"
    if list[key]
      puts key
      puts "Tag #{item.tag.name}"
      puts "Topic #{item.topic.title}"
      return
    end
    list[key] = item
  end
end

task :go_3_add_topic_tag => :environment do
  Topic.all.each do |topic|
    print "."
    topic.add_tag(topic.status_cn_name)
  end
  puts "."
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
