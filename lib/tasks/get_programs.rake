namespace :get_programs do
  desc "radikoから週間番組表を取得する"
  task get_programs: :environment do
    require 'net/http'
    require 'nokogiri'

    area_id = 'JP13' # area_idの定義（東京都）

    # station_idの取得
    station_id_uri = URI("http://radiko.jp/v3/station/list/#{area_id}.xml")
    station_id_response = Net::HTTP.get(station_id_uri)
    
    station_id_doc = Nokogiri::XML(station_id_response) # 取得したXMLデータを解析

    # station_idの抜き取り
    station_id_list = []

    station_id_doc.xpath('//station/id').each do |s|
      station_id_list << s.text
    end

    # staion_idごとに以下を繰り返し
    station_id_list.each do |id|
      weekly_program_uri = URI("http://radiko.jp/v3/program/station/weekly/#{id}.xml")
      weekly_program_response = Net::HTTP.get(weekly_program_uri)

    # XMLを解析
    weekly_program_doc = Nokogiri::XML(weekly_program_response)

    # 必要な情報取得
    weekly_program_list = []
    
    weekly_program_doc.xpath('radiko/stations/station/progs/prog').each do |p|
      title = p.at('title').text # タイトル
      start_datetime = p('ft') # 開始時間
      end_datetime = p('to') # 終了時間
      url = p.at('url')&.text || "" # 番組url

      # メールアドレス
      email = ""
      %w[info info/dev desc desc/div].each do |element_name |
        element = p.at(element_name)
        if element
          email_matches = element.inner_text.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i)
          if email_matches.any?
            email = email_matches.first
            break
          end
        end
      end

      performer = p.at('pfm')&.text || "" # パーソナリティ

      time = p['dur'] # 時間

      weekly_program_list << { station_id: id, title: title, start_datetime: start_datetime, end_datetime: end_datetime, url: url, email: email, performer: performer, time: time}
    end


    # end
  end
end
