class Topic < ActiveRecord::Base
  has_many :topic_tags
  has_many :tags, :through => :topic_tags

  # default_scope -> { order('manual_salary DESC, analyzed_release_at DESC') }
  #default_scope -> { order('analyzed_salary DESC') }
  default_scope -> { order('analyzed_release_at DESC') }

  def self.search(key)
    if key.blank?
      return []
    end

    #WHERE column LIKE 'Text%' OR column LIKE 'Hello%' OR column LIKE 'That%'
    #Topic.where("title LIKE ? OR", "%#{key}%")
    condition = ""

    columns = []
    columns << "title"
    columns << "analyzed_salary"
    columns << "analyzed_author"
    columns << "manual_salary"
    columns << "manual_memo"
    columns << "analyzed_company"
    columns << "manual_company"
    columns.each do |column|
      condition += " OR " unless condition.blank?
      condition += "#{column} LIKE ?"
    end

    params = []
    columns.count.times.each do
      params << "%#{key}%"
    end

    return self.where(condition, *params)
  end

  def analyzed_author_url
    "http://ruby-china.org/#{self.analyzed_author}"
  end

  def analyzed_release_at_text
    if analyzed_release_at
      return analyzed_release_at.strftime("%Y-%m-%d")
    else
      return "无"
    end
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

  def tag_name
    list = self.tags.collect do |t|
      t.name
    end
    list.join(' ')
  end

end
