class TopicsController < ApplicationController

  def index
    @subjects = Topic.all
  end

end