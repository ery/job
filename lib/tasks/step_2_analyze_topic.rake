
desc "Step 2 analyze topic"
task :step_2_analyze_topic => :environment do
  Topic.all.each do |topic|
    print "."
    analyze_topic topic
  end
  puts "."
end

def analyze_topic(topic)
  topic = Topic.find_by_url!(topic.url)
  topic.salary = analyze_salary(topic)
  topic.save!
end

def analyze_salary(topic)
  doc = Nokogiri::HTML(open(topic.file))
  description = doc.css('.topic .body').first.content
  description.gsub!("\n", ' ')

  salary = /薪.{1,50}/.match(description)

  return salary.to_s
end

