require 'test_helper'

class WeathericonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weathericon = weathericons(:one)
  end

  test "should get index" do
    get weathericons_url
    assert_response :success
  end

  test "should get new" do
    get new_weathericon_url
    assert_response :success
  end

  test "should create weathericon" do
    assert_difference('Weathericon.count') do
      post weathericons_url, params: { weathericon: { name: @weathericon.name } }
    end

    assert_redirected_to weathericon_url(Weathericon.last)
  end

  test "should show weathericon" do
    get weathericon_url(@weathericon)
    assert_response :success
  end

  test "should get edit" do
    get edit_weathericon_url(@weathericon)
    assert_response :success
  end

  test "should update weathericon" do
    patch weathericon_url(@weathericon), params: { weathericon: { name: @weathericon.name } }
    assert_redirected_to weathericon_url(@weathericon)
  end

  test "should destroy weathericon" do
    assert_difference('Weathericon.count', -1) do
      delete weathericon_url(@weathericon)
    end

    assert_redirected_to weathericons_url
  end
end
