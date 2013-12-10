class Tag < ActiveRecord::Base
  has_many :topics, :through => :topic_tags
  validates(:name,
    :presence   => {:message => '名称不能为空'},
    :uniqueness => {:message => '名称不能重复'})
end
