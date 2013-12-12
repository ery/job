class Tag < ActiveRecord::Base
  has_many :topic_tags, :dependent => :restrict_with_error
  has_many :topics, :through => :topic_tags
  validates(:name,
    :presence   => {:message => '名称不能为空'},
    :uniqueness => {:message => '名称不能重复'})
  default_scope -> { order('"order" ASC') }

  INBOX = '收件箱'
  OTHER = '其他'

  def self.get_inbox
    name = INBOX
    tag = Tag.find_by_name(name)
    unless tag
      tag = Tag.create!(name: name, order: 1)
    end
    return tag
  end
end
