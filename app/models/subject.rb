class Subject < ActiveRecord::Base
  module Status
    INBOX   = "inbox"
    IGNORED = "ignored"
    CARED   = "cared"
  end

  belongs_to :topic, :foreign_key => :url, :primary_key => :url

  def analyzed_salary
    topic.analyzed_salary
  end

  def analyzed_author
    topic.analyzed_author
  end

  scope :inbox,   -> { where(:status => Status::INBOX) }
  scope :ignored, -> { where(:status => Status::IGNORED) }
  scope :cared,   -> { where(:status => Status::CARED) }

end
