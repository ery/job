
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
  doc = Nokogiri::HTML(open(topic.file))
  topic.analyzed_salary = analyze_salary(doc)
  topic.analyzed_author = analyze_author(doc)
  topic.save!
end

def analyze_salary(doc)
  description = doc.css('.topic .body').first.content
  description.gsub!("\n", ' ')

  %w(工资 薪水 年薪 月薪 薪资 待遇 薪酬 Salary).each do |keyword|
    salary = /#{keyword}.{1,50}/.match(description)
    if salary
      return salary.to_s
    end
  end

  return ""
end

def analyze_author(doc)
  #<a data-author="true" data-name="isofttalent" href="/isofttalent">isofttalent</a>
  author = doc.css('.topic .infos .info a')[1].content.to_s
  return author
end
