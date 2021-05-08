class Batch::Daily
  def mail
    DailyMailer.daily_email.deliver_now
  end
end