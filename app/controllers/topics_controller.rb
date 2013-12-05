class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy, :ignore, :care]

  def index
    @topics = Topic.where(:status => Topic::Status::NONE)
  end

  def ignored
    @topics = Topic.where(:status => Topic::Status::IGNORED)
  end

  def cared
    @topics = Topic.where(:status => Topic::Status::CARED)
  end

  def all
    @topics = Topic.all
  end

  def ignore
    @topic.status = Topic::Status::IGNORED
    @topic.save!
    redirect_to :action => :index
  end

  def care
    @topic.status = Topic::Status::CARED
    @topic.save!
    redirect_to :action => :index
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

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render action: 'show', status: :created, location: @topic }
      else
        format.html { render action: 'new' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title, :url, :memo)
    end
end
