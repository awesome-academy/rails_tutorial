require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:one) # Lấy user từ fixtures
    mail = UserMailer.account_activation(user) # Gọi mailer

    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match user.name, mail.body.encoded # Kiểm tra nội dung email
  end
end
