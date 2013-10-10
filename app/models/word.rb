# coding: utf-8
=begin
 * 日本語検索用テーブル
 *  
 * 定義：
 * 日本語表示、よみかた（ひらがな）、よみかた（せいおん）、よみかたの文字数
 * 
=end
class Word
  include Mongoid::Document
  field :surface, type: String
  field :reading, type: String
  field :reading_seion, type: String
  field :count_hira, type: Integer
  
  def self.init
    # 初期化
    # ダミーとしてデータを格納する
    if Word.count == 0 then
      Word.create(surface: "布団", reading: "ふとん", reading_seion: "ふとん", count_hira:3)
      Word.create(surface: "牛丼", reading: "ぎゅうどん", reading_seion: "きゅうとん", count_hira:4)
      Word.create(surface: "うどん", reading: "うどん", reading_seion: "うとん", count_hira:3)
      Word.create(surface: "ヴィトン", reading: "びとん", reading_seion: "ひとん", count_hira:3)
      Word.create(surface: "Cloudn", reading: "くらうどん", reading_seion: "くらうとん", count_hira:5)
      Word.create(surface: "クリプトン", reading: "くりぷとん", reading_seion: "くりふとん", count_hira:5)
      Word.create(surface: "マトン", reading: "まとん", reading_seion: "まとん", count_hira:3)
      Word.create(surface: "オートマトン", reading: "おーとまとん", reading_seion: "おーとまとん", count_hira:6)
      Word.create(surface: "ミトン", reading: "みとん", reading_seion: "みとん", count_hira:3)
      Word.create(surface: "バリトン", reading: "ばりとん", reading_seion: "はりとん", count_hira:4)
      Word.create(surface: "スケルトン", reading: "すけるとん", reading_seion: "すけるとん", count_hira:5)
      Word.create(surface: "プロトン", reading: "ぷろとん", reading_seion: "ふろとん", count_hira:4)
      Word.create(surface: "渾沌", reading: "こんとん", reading_seion: "こんとん", count_hira:4)
      Word.create(surface: "とんとん", reading: "とんとん", reading_seion: "とんとん", count_hira:4)
      Word.create(surface: "バドミントン", reading: "ばどみんとん", reading_seion: "はとみんとん", count_hira:6)
      Word.create(surface: "おいどん", reading: "おいどん", reading_seion: "おいとん", count_hira:4)
      Word.create(surface: "うどん", reading: "うどん", reading_seion: "うとん", count_hira:3)
      Word.create(surface: "焼きうどん", reading: "やきうどん", reading_seion: "やきうとん", count_hira:5)
      Word.create(surface: "狐饂飩", reading: "きつねうどん", reading_seion: "きつねうとん", count_hira:6)
      Word.create(surface: "ハルマゲドン", reading: "はるまげどん", reading_seion: "はるまけとん", count_hira:6)
      Word.create(surface: "かつどん", reading: "かつどん", reading_seion: "かつとん", count_hira:4)
      Word.create(surface: "マストドン", reading: "ますとどん", reading_seion: "ますととん", count_hira:5)
      Word.create(surface: "うな丼", reading: "うなどん", reading_seion: "うなとん", count_hira:4)
      Word.create(surface: "ラドン", reading: "らどん", reading_seion: "らとん", count_hira:3)
      Word.create(surface: "昼行灯", reading: "ひるあんどん", reading_seion: "ひるあんとん", count_hira:6)
      Word.create(surface: "つっけんどん", reading: "つっけんどん", reading_seion: "つっけんとん", count_hira:6)
      Word.create(surface: "おさんどん", reading: "おさんどん", reading_seion: "おさんとん", count_hira:5)
      Word.create(surface: "天丼", reading: "てんどん", reading_seion: "てんとん", count_hira:4)
      Word.create(surface: "半ドン", reading: "はんどん", reading_seion: "はんとん", count_hira:4)
    end
  end
  
end
