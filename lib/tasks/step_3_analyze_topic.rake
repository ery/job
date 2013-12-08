
desc "Step 3 analyze topic"
task :step_3_analyze_topic => :environment do
  puts "Step 3 analyze topic"
  Topic.all.each do |topic|
    print "."
    analyze_topic topic
  end
  puts "."
end

def analyze_topic(topic)
  topic = Topic.find_by_url!(topic.url)
  topic.analyzed_salary = analyze_salary(topic)
  topic.save!
end

def analyze_salary(topic)
  doc = Nokogiri::HTML(open(topic.file))
  description = doc.css('.topic .body').first.content
  description.gsub!("\n", ' ')

  %w(工资 薪水 年薪 月薪 薪资 待遇).each do |keyword|
    salary = /#{keyword}.{1,50}/.match(description)
    if salary
      return salary.to_s
    end
  end

  return ""
end
