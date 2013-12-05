class Topic < ActiveRecord::Base
  module Status
    INBOX   = "inbox"
    IGNORED = "ignored"
    CARED   = "cared"
  end

  scope :inbox,   -> { where(:status => Status::INBOX) }
  scope :ignored, -> { where(:status => Status::IGNORED) }
  scope :cared,   -> { where(:status => Status::CARED) }

end
