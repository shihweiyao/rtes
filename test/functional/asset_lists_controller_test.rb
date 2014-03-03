require 'test_helper'

class AssetListsControllerTest < ActionController::TestCase
  setup do
    @asset_list = asset_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asset_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asset_list" do
    assert_difference('AssetList.count') do
      post :create, asset_list: { location: @asset_list.location, name: @asset_list.name, owner: @asset_list.owner, time: @asset_list.time }
    end

    assert_redirected_to asset_list_path(assigns(:asset_list))
  end

  test "should show asset_list" do
    get :show, id: @asset_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @asset_list
    assert_response :success
  end

  test "should update asset_list" do
    put :update, id: @asset_list, asset_list: { location: @asset_list.location, name: @asset_list.name, owner: @asset_list.owner, time: @asset_list.time }
    assert_redirected_to asset_list_path(assigns(:asset_list))
  end

  test "should destroy asset_list" do
    assert_difference('AssetList.count', -1) do
      delete :destroy, id: @asset_list
    end

    assert_redirected_to asset_lists_path
  end
end
