
desc "Go"
task :go_init_manual_company => :environment do
  Topic.all.each do |topic|
    topic.manual_company = topic.analyzed_company
    topic.save!
    print "."
  end
end
