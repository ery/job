class Topic < ActiveRecord::Base
  module Status
    NONE    = "none"
    IGNORED = "ignored"
    CARED   = "cared"
  end
end
