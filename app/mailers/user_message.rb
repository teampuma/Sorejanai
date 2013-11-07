class UserMessage < ActionMailer::Base
  default from: "from@example.com"

  def send_mail(to, body)
  mail(
    :from => "teampuma774@gmail.com",
    :to => to,
    :subject => "[Sorejanai]今日のメッセージ",
    :body => body
    )
  end
end
