require "test_helper"

class DrugsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get drugs_index_url
    assert_response :success
  end

  test "should get show" do
    get drugs_show_url
    assert_response :success
  end

  test "should get search" do
    get drugs_search_url
    assert_response :success
  end

  test "should get summarize" do
    get drugs_summarize_url
    assert_response :success
  end
end
