require 'test_helper'

class SubjectsControllerTest < ActionController::TestCase
  setup do
    @topic = subjects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subjects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic" do
    assert_difference('Subject.count') do
      post :create, topic: { memo: @topic.memo, title: @topic.title, url: @topic.url }
    end

    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should show topic" do
    get :show, id: @topic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @topic
    assert_response :success
  end

  test "should update topic" do
    patch :update, id: @topic, topic: { memo: @topic.memo, title: @topic.title, url: @topic.url }
    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should destroy topic" do
    assert_difference('Subject.count', -1) do
      delete :destroy, id: @topic
    end

    assert_redirected_to subjects_path
  end
end
