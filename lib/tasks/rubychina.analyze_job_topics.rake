require 'open-uri'

namespace :rubychina do

  desc "Analyze job subjects"
  task :analyze_job_subjects => :environment do
    RubychinaSubject.all.each do |rubychina_topic|
    end
  end

end
