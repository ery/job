class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :add_tag, :remove_tag, :put_ignored, :put_cared, :put_inbox]

  def show
  end

  def index
    @topics = Topic.all
  end

  def search
    @topics = Topic.search(params[:key])
  end

  def untaged
    @topics = []
    Topic.all.each do |topic|
      if topic.tags.count == 0
        @topics << topic
      end
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to @topic, notice: '修改成功.'
    else
      render action: 'edit'
    end
  end

  def add_tag
    tag_name = params[:tag]
    @topic.add_tag tag_name
    redirect_to @topic, notice: "添加标签成功 #{tag_name}"
  end

  def remove_tag
    tag_name = params[:tag]
    @topic.remove_tag tag_name
    redirect_to @topic, notice: "移除标签成功 #{tag_name}"
  end

  def merge
    ids = params[:ids]
    topic = Topic.find(ids.first)
    redirect_to topic, notice: '合并成功.'
    binding.pry
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:manual_salary, :manual_memo, :manual_company)
  end

end

