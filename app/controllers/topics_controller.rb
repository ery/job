class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy, :ignore, :care, :putinbox]

  def index
    @topics = Topic.all
  end

  def inbox
    @topics = Topic.inbox
  end

  def ignored
    @topics = Topic.ignored
  end

  def cared
    @topics = Topic.cared
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

  def new
    @topic = Topic.new
  end

  def edit
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to @topic, notice: 'Topic was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to @topic, notice: 'Topic was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def topic_params
    params.require(:topic).permit(:title, :url, :memo, :monthly_salary, :annual_salary)
  end

end
