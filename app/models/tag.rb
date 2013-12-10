class Tag < ActiveRecord::Base

  validates(:name,
    :presence   => {:message => '名称不能为空'},
    :uniqueness => {:message => '名称不能重复'})

end
