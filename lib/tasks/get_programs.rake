namespace :get_programs do
  desc "放送局登録"
  task get_station: :environment do
    require 'net/http'
    require 'nokogiri'

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
  end

  desc "radikoから週間番組表を取得する"
  task get_weekly_programs: :environment do
    require 'net/http'
    require 'nokogiri'

    # station_list作成
    station_list = Station.all
    
    # staion_listごとに以下を繰り返し
    station_list.each do |s|
      weekly_program_uri = URI("http://radiko.jp/v3/program/station/weekly/#{s.station_id}.xml")
      weekly_program_response = Net::HTTP.get(weekly_program_uri)

      # XMLを解析
      weekly_program_doc = Nokogiri::XML(weekly_program_response)

      # 必要な情報取得
      weekly_program_list = []
    
      weekly_program_doc.xpath('radiko/stations/station/progs/prog').each do |p|
        title = p.at('title').text # タイトル
        start_datetime = p['ft'] # 開始時間
        #start_datetime = DateTime.strptime(ft_element, "%Y%m%d%H%M%S")
        end_datetime = p['to'] # 終了時間
        #end_datetime = DateTime.strptime(to_element, "%Y%m%d%H%M%S")
        url = p.at('url')&.text || "" # 番組url

        # メールアドレス
        email = ""
        %w[info info/dev desc desc/div].each do | element_name |
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
        
        weekly_program_list << { station_id: s.id, title: title, start_datetime: start_datetime, end_datetime: end_datetime, url: url, email: email, performer: performer, time: time }

        # Programテーブルに登録
        weekly_program_list.each do |program_data|
          program = Program.find_or_initialize_by(
          title: program_data[:title],
          start_datetime: program_data[:start_datetime]
          )
        
          program.update(
            station_id: program_data[:station_id],
            end_datetime: program_data[:end_datetime],
            url: program_data[:url],
            email: program_data[:email],
            performer: program_data[:performer],
            time: program_data[:time])
        end
      end
    end
  end
end
