class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :ignore, :care, :putinbox]

  def inbox
    @topics = Topic.inbox
  end

  def ignored
    @topics = Topic.ignored.order(:manual_salary)
  end

  def cared
    @topics = Topic.cared.order(:manual_salary)
  end

  def index
    @topics = Topic.all
  end

  def putinbox
    @topic.status = Topic::Status::INBOX
    @topic.save!
    redirect_to :back
  end

  def ignore
    @topic.status = Topic::Status::IGNORED
    @topic.save!
    redirect_to :back
  end

  def care
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
    params.require(:topic).permit(:manual_salary, :manual_memo)
  end

end

