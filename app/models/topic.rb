class Topic < ActiveRecord::Base
  module Status
    INBOX   = "inbox"
    IGNORED = "ignored"
    CARED   = "cared"
    NONE    = "none"
  end
  has_many :topic_tags
  has_many :tags, :through => :topic_tags
  default_scope   -> { order('manual_salary DESC, analyzed_release_at DESC') }
  scope :inbox,   -> { where(:status => Status::INBOX) }
  scope :ignored, -> { where(:status => Status::IGNORED) }
  scope :cared,   -> { where(:status => Status::CARED) }

  def analyzed_author_url
    "http://ruby-china.org/#{self.analyzed_author}"
  end

  def self.status
    list = []
    list << ["收件箱", Status::INBOX]
    list << ["关注", Status::CARED]
    list << ["忽略", Status::IGNORED]
    list << ["无", Status::NONE]
    return list
  end

  def self.sort_by_field(list, field, is_asc = true)
    list.sort do |x,y|
      x_value = x.send(field).to_s
      y_value = y.send(field).to_s
      if is_asc
        y_value <=> x_value
      else
        x_value <=> y_value
      end
    end
  end

  def self.tags_list
    list = []
    Tag.all.each do |tag|
      list << [tag.name, tag.id]
    end
    return list
  end

  def tag_ids
    ids = []
    self.tags.each do |tag|
      ids << tag.id
    end
    return ids
  end

  def tag_ids=(ids)
  end

end
