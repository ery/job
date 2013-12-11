class TopicTag < ActiveRecord::Base
  belongs_to :topic
  belongs_to :tag
  validates_presence_of :topic_id, message: '帖子ID 不能为空'
  validates_presence_of :tag_id,   message: '标签ID 不能为空'
  validates_uniqueness_of :tag_id, scope: :topic_id, message: '帖子ID+标签ID 不能重复'
end
