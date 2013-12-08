require 'open-uri'

namespace :topic do

  desc "Analyze"
  task :analyze => :environment do
    Topic.all.each do |topic|
    end
  end

end
