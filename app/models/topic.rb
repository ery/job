class Topic < ActiveRecord::Base
  module Status
    INBOX   = "inbox"
    IGNORED = "ignored"
    CARED   = "cared"
    NONE    = "none"
  end

  has_many :topic_tags
  has_many :tags, :through => :topic_tags

  default_scope -> { order('manual_salary DESC, analyzed_release_at DESC') }
  scope :inbox, -> { where(:status => Status::INBOX) }

  def analyzed_author_url
    "http://ruby-china.org/#{self.analyzed_author}"
  end

  def status_cn_name
    case status
    when Topic::Status::INBOX
      return "收件箱"
    when Topic::Status::IGNORED
      return "已忽略"
    when Topic::Status::CARED
      return "已关注"
    when Topic::Status::NONE
      return "无状态"
    end
  end

  def self.status
    list = []
    list << ["收件箱", Status::INBOX]
    list << ["关注", Status::CARED]
    list << ["忽略", Status::IGNORED]
    list << ["无", Status::NONE]
    return list
  end

  def is_taged(tag)
    self.topic_tags.exists?(tag_id: tag.id)
  end

  def add_tag(tag_name)
    tag = Tag.find_by_name(tag_name)
    unless tag
      tag = Tag.create!(name: tag_name)
    end

    topic = self
    topic_tag = {topic_id: topic.id, tag_id: tag.id}

    if TopicTag.exists?(topic_tag)
      return
    end

    TopicTag.create!(topic_tag)
  end

  def remove_tag(tag_name)
    tag = Tag.find_by_name(tag_name)
    unless tag
      return
    end

    topic_tag = self.topic_tags.find_by_tag_id(tag.id)
    unless topic_tag
      return
    end

    topic_tag.destroy!
  end

end
