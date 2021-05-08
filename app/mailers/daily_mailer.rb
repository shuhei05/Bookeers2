class DailyMailer < ApplicationMailer
  def daily_email
    mail(bcc: User.pluck(:email), subject: "Daily Report of Your Record")
  end
end
