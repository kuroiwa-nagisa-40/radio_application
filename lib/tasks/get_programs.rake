namespace :get_programs do
  desc "放送局登録"
  task get_station: :environment do
    require 'net/http'
    require 'nokogiri'

    # キャッシュから放送局情報を取得
    station_data = Rails.cache.read('station_data')

    unless station_data
      area_id = 'JP13' # area_idの定義（東京都）

      # station_idの取得
      station_id_uri = URI("http://radiko.jp/v3/station/list/#{area_id}.xml")
      station_id_response = Net::HTTP.get(station_id_uri)
      
      station_id_doc = Nokogiri::XML(station_id_response) # 取得したXMLデータを解析

      # station_idの抜き取り
      station_id_list = []

      station_id_doc.xpath('//station').each do |s|
        id = s.at('id').text
        name = s.at('name').text
        station_id_list << { station_id: id, name: name }
      end
    
      # stationテーブルに登録
      station_id_list.each do |station_data|
        station = Station.find_by(station_id: station_data[:station_id])
        unless station # Stationテーブルに既にIDがない場合登録する
          Station.create(station_data)
        end
      end

      # 取得した放送局情報をキャッシュに保存
      Rails.cache.write('station_data', station_id_list, expires_in: 1.month)
    end
  end

  desc "radikoから週間番組表を取得する"
  task get_weekly_programs: :environment do
    require 'net/http'
    require 'nokogiri'
    require 'parallel'
    
    # 放送曲ごとに1日ずつ取得する
    # 1週間分の日付の配列を作成
    start_date = Date.today
    week_dates = (0..6).map { |i| (start_date + i).strftime("%Y%m%d") }

    # station_list作成
    station_list = Station.all

    week_dates.each do |date|
      dayly_program_data = []

      Parallel.each(station_list, in_threads: 2)do |s|
        dayly_program_uri = URI("http://radiko.jp/v3/program/station/date/#{date}/#{s.station_id}.xml")
        dayly_program_reaponse = Net::HTTP.get(dayly_program_uri)
        dayly_program_doc = Nokogiri::XML(dayly_program_reaponse)

        dayly_program_list =[]
        dayly_program_doc.xpath('radiko/stations/station/progs/prog').each do |p|
          title = p.at('title').text # タイトル
          start_datetime = p['ft'] # 開始時間
          end_datetime = p['to'] # 終了時間
          url = p.at('url')&.text || "" # 番組url
          email = ""
          %w[info info/dev desc desc/div].each do |element_name|
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

          dayly_program_list << {
            station_id: s.id,
            title: title,
            start_datetime: start_datetime,
            end_datetime: end_datetime,
            url: url,
            email: email,
            performer: performer,
            time: time
          }
        end

        dayly_program_data.concat(dayly_program_list)
      end

      Program.import dayly_program_data, on_duplicate_key_ignore: { conflict_target: [:title, :start_datetime, :station_id] }
    end
  end
end
