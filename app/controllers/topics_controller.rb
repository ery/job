class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :add_tag, :remove_tag, :put_ignored, :put_cared, :put_inbox]

  def index
    @topics = Topic.inbox
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

  def ignored
    @topics = Topic.ignored
  end

  def cared
    @topics = Topic.cared
  end

  def all
    @topics = Topic.all
  end

  def put_inbox
    @topic.status = Topic::Status::INBOX
    @topic.save!
    redirect_to :back
  end

  def put_ignored
    @topic.status = Topic::Status::IGNORED
    @topic.save!
    redirect_to :back
  end

  def put_cared
    @topic.status = Topic::Status::CARED
    @topic.save!
    redirect_to :back
  end

  def show
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

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:manual_salary, :manual_memo, :status, :tag_ids => [])
  end

end

