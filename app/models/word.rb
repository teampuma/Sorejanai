# coding: utf-8
=begin
 * 日本語検索用テーブル
 *  
 * 定義：
 * 日本語表示、よみかた（ひらがな）、よみかたの文字数
 * 
=end
class Word
  include Mongoid::Document
  field :surface, type: String
  field :reading, type: String
  field :count_hira, type: Integer
  
  def self.init
    # 初期化
    # ダミーとしてデータを格納する
    if Word.count == 0 then
      Word.create(surface: "布団", reading: "ふとん", count_hira:3)
      Word.create(surface: "牛丼", reading: "ぎゅうどん", count_hira:5)
      Word.create(surface: "うどん", reading: "うどん", count_hira:3)
    end
  end
  
end
