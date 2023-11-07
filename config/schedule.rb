require File.expand_path(File.dirname(__FILE__) + "/environment") # Rails.root(Railsメソッド)を使用するために必要
rails_env = ENV['RAILS_ENV'] || :development # cronを実行する環境変数(:development, :product, :test)
set :environment, rails_env # cronを実行する環境変数をセット
set :output, "#{Rails.root}/log/crontab.log" # cronのログ出力用ファイル

every 1.month, at: 'start of the month at 0am' do
  rake "get_programs:get_station"
end

every :monday, at: '2:00 am' do
  rake "get_programs:get_weekly_programs"
end