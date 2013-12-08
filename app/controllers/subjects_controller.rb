class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :ignore, :care, :putinbox]

  def inbox
    @subjects = Subject.inbox
  end

  def ignored
    @subjects = Subject.ignored
  end

  def cared
    @subjects = Subject.cared
  end

  def index
    @subjects = Subject.all
  end

  def putinbox
    @subject.status = Subject::Status::INBOX
    @subject.save!
    redirect_to :back
  end

  def ignore
    @subject.status = Subject::Status::IGNORED
    @subject.save!
    redirect_to :back
  end

  def care
    @subject.status = Subject::Status::CARED
    @subject.save!
    redirect_to :back
  end

  def show
  end

  def edit
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      redirect_to @subject, notice: 'Subject was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @subject.update(subject_params)
      redirect_to @subject, notice: 'Subject was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    params.require(:subject).permit(:manual_salary, :manual_memo)
  end

end

