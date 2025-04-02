require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should get create" do
    get login_path
    assert_response :success
  end

  test "should get destroy" do
    user = users(:one)  # Lấy user từ fixtures
  log_in_as(user)     # Đăng nhập user trước khi logout
  delete logout_path  # Gọi action destroy
  assert_redirected_to root_url
  assert_not session[:user_id]  # Kiểm tra session đã bị xóa
  end
end
