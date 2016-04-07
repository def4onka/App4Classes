require 'test_helper'

class AfilesControllerTest < ActionController::TestCase
  setup do
    @afile = afiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:afiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create afile" do
    assert_difference('Afile.count') do
      post :create, afile: { document_id: @afile.document_id, path: @afile.path, source: @afile.source }
    end

    assert_redirected_to afile_path(assigns(:afile))
  end

  test "should show afile" do
    get :show, id: @afile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @afile
    assert_response :success
  end

  test "should update afile" do
    patch :update, id: @afile, afile: { document_id: @afile.document_id, path: @afile.path, source: @afile.source }
    assert_redirected_to afile_path(assigns(:afile))
  end

  test "should destroy afile" do
    assert_difference('Afile.count', -1) do
      delete :destroy, id: @afile
    end

    assert_redirected_to afiles_path
  end
end
