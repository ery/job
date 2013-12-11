class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def inbox
    @tag = Tag.find_by_name!('收件箱')
    render :show
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to @tag, notice: '新建成功'
    else
      render action: 'new'
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to @tag, notice: '修改成功'
    else
      render action: 'edit'
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    if @tag.destroy
      redirect_to tags_path, notice: '删除成功'
    else
      redirect_to tag_path(@tag), notice: '删除失败'
    end
  end

  def tag_params
    params.require(:tag).permit(:name, :order)
  end

end

