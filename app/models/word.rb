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
      Word.create(surface: "牛丼", reading: "ぎゅうどん", reading_seion: "ぎゅうとん", count_hira:5)
      Word.create(surface: "うどん", reading: "うどん", reading_seion: "うとん", count_hira:3)
      Word.create(surface: "ヴィトン", reading: "びとん", reading_seion: "ひとん", count_hira:3)
      Word.create(surface: "Cloudn", reading: "くらうどん", reading_seion: "くらうとん", count_hira:5)
    end
  end
  
end
