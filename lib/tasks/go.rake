
desc "Go"
task :go_init_manual_company => :environment do
  Topic.all.each do |topic|
    topic.manual_company = topic.analyzed_company
    topic.save!
    print "."
  end
end

desc "Find marco"
task :find_marco => :environment do
  marco = ""
  Topic.all.each do |t|
    memo = t.manual_memo || ""
    if memo.include?("the.timely")
      marco = t
    end
  end
  puts marco.title
  puts marco.url
end
