# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
env :PATH, ENV['PATH']
set :output, 'log/cron.log'  #ログファイルの出力先を指定
set :environment, :development
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end


every 1.days, at: '9:00 am' do

# DailyMailerのdaily_emailメソッド実行
 #runner "DailyMailer.daily_email"
 runner "Batch::Daily.new.mail"
 
end

# Learn more: http://github.com/javan/whenever
