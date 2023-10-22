namespace :get_programs do
  desc "radikoから週間番組表を取得する"
  task get_programs: :environment do
    require 'net/http'
    require 'rexml/document'

    # area_idの定義（東京都）
    area_id = 'JP13'

    # station_idの取得
    station_id_uri = URI("http://radiko.jp/v3/station/list/#{area_id}.xml")
    station_id_response = Net::HTTP.get(station_id_uri)

    # 取得したXMLデータを解析
    station_id_doc = REXML::Document.new(station_id_response)

    # station_idの抜き取り
    station_id_list = []

    station_id_doc.elements.each('stations/station') do |s|
      station_id = s.elements['id'].text
      station_id_list << station_id
    end

    puts station_id_list
  end
end
