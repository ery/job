class RubychinaTopicsController < ApplicationController

  def index
    @topics = RubychinaTopic.all
  end

end