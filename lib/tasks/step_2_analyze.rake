
desc "Step 2 analyze"
task :step_2_analyze => :environment do
  puts "Step 2 analyze"
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
  topic.analyzed_release_at = analyze_release_at(doc)
  topic.analyzed_company = analyze_company(topic)
  topic.save!
end

def analyze_salary(doc)
  description = get_doc_description(doc)

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
  element = doc.css('.topic .infos .info a')[1]
  author = element.content.to_s
  return author
end

def analyze_release_at(doc)
  #<abbr class="timeago" title="2013-12-01T11:52:51+08:00">9天前</abbr>发布
  element = doc.css('.topic .infos .info abbr.timeago').first
  release_at = element[:title].to_s
  return release_at
end

def analyze_company(topic)
  company = analyze_company_m1(topic)
  return company
end

def analyze_company_m1(topic)
  #[北京]北京圣天博科技有限公司--招 2 枚--rails 工程师

  company = /\[北京\].{1,50}/.match(topic.title)
end

def get_doc_description(doc)
  description = doc.css('.topic .body').first.content
  return description.gsub("\n", ' ')
end

