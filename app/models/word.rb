# coding: utf-8
=begin
 * 日本語検索用テーブル
 *  
 * 定義：
 * 日本語表示、よみかた（ひらがな）、よみかた（せいおん）、よみかた（検索用）、よみかたの文字数
 * 
=end
class Word
  include Mongoid::Document
  field :surface, type: String
  field :reading, type: String
  field :reading_seion, type: String
  field :reading_search, type: String
  field :count_hira, type: Integer
  field :loc, type: Array

  index({ loc: "2d" }, { min: -200, max: 200 })  

  def self.init
    # 初期化
    # ダミーとしてデータを格納する
    if Word.count == 0 then
      Word.create(surface: "布団", reading: "ふとん", reading_seion: "ふとん", reading_search: "とん", count_hira:3)
      Word.create(surface: "牛丼", reading: "ぎゅうどん", reading_seion: "きゅうとん", reading_search: "とん", count_hira:4)
      Word.create(surface: "うどん", reading: "うどん", reading_seion: "うとん", reading_search: "とん", count_hira:3)
      Word.create(surface: "ヴィトン", reading: "びとん", reading_seion: "ひとん", reading_search: "とん", count_hira:3)
      Word.create(surface: "Cloudn", reading: "くらうどん", reading_seion: "くらうとん", reading_search: "とん", count_hira:5)
      Word.create(surface: "クリプトン", reading: "くりぷとん", reading_seion: "くりふとん", reading_search: "とん", count_hira:5)
      Word.create(surface: "マトン", reading: "まとん", reading_seion: "まとん", reading_search: "とん", count_hira:3)
      Word.create(surface: "オートマトン", reading: "おーとまとん", reading_seion: "おーとまとん", reading_search: "とん", count_hira:6)
      Word.create(surface: "ミトン", reading: "みとん", reading_seion: "みとん", reading_search: "とん", count_hira:3)
      Word.create(surface: "バリトン", reading: "ばりとん", reading_seion: "はりとん", reading_search: "とん", count_hira:4)
      Word.create(surface: "スケルトン", reading: "すけるとん", reading_seion: "すけるとん", reading_search: "とん", count_hira:5)
      Word.create(surface: "プロトン", reading: "ぷろとん", reading_seion: "ふろとん", reading_search: "とん", count_hira:4)
      Word.create(surface: "渾沌", reading: "こんとん", reading_seion: "こんとん", reading_search: "とん", count_hira:4)
      Word.create(surface: "とんとん", reading: "とんとん", reading_seion: "とんとん", reading_search: "とん", count_hira:4)
      Word.create(surface: "バドミントン", reading: "ばどみんとん", reading_seion: "はとみんとん", reading_search: "とん", count_hira:6)
      Word.create(surface: "おいどん", reading: "おいどん", reading_seion: "おいとん", reading_search: "とん", count_hira:4)
      Word.create(surface: "うどん", reading: "うどん", reading_seion: "うとん", reading_search: "とん", count_hira:3)
      Word.create(surface: "焼きうどん", reading: "やきうどん", reading_seion: "やきうとん", reading_search: "とん", count_hira:5)
      Word.create(surface: "狐饂飩", reading: "きつねうどん", reading_seion: "きつねうとん", reading_search: "とん", count_hira:6)
      Word.create(surface: "ハルマゲドン", reading: "はるまげどん", reading_seion: "はるまけとん", reading_search: "とん", count_hira:6)
      Word.create(surface: "かつどん", reading: "かつどん", reading_seion: "かつとん", reading_search: "とん", count_hira:4)
      Word.create(surface: "マストドン", reading: "ますとどん", reading_seion: "ますととん", reading_search: "とん", count_hira:5)
      Word.create(surface: "うな丼", reading: "うなどん", reading_seion: "うなとん", reading_search: "とん", count_hira:4)
      Word.create(surface: "ラドン", reading: "らどん", reading_seion: "らとん", reading_search: "とん", count_hira:3)
      Word.create(surface: "昼行灯", reading: "ひるあんどん", reading_seion: "ひるあんとん", reading_search: "とん", count_hira:6)
      Word.create(surface: "つっけんどん", reading: "つっけんどん", reading_seion: "つっけんとん", reading_search: "とん", count_hira:6)
      Word.create(surface: "おさんどん", reading: "おさんどん", reading_seion: "おさんとん", reading_search: "とん", count_hira:5)
      Word.create(surface: "天丼", reading: "てんどん", reading_seion: "てんとん", reading_search: "とん", count_hira:4)
      Word.create(surface: "半ドン", reading: "はんどん", reading_seion: "はんとん", reading_search: "とん", count_hira:4, loc:[1,2])
    end
  end

  def self.daku_to_sei(s)
    # 濁点、半濁点を考慮するため
    # ひらがなの濁音を清音に変換する
    daku = "がぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽ"
    sei = "かきくけこさしすせそたちつてとはひふへほはひふへほ"

    ret = s
    for i in 0...daku.size
      ret = ret.gsub(daku[i], sei[i])
    end
    return ret
  end
  
  def self.get_word(s)
    # 語尾ふた文字が共通する言葉を取得
    search = daku_to_sei(s)[-2,2]
    # 検索結果をそのまま返却
    refs = where(reading_search: search)
    return refs
  end

  def self.get_word_noloc(s)
    # 語尾ふた文字が共通する言葉を取得
    search = daku_to_sei(s)[-2,2]
    # 地図情報なしのデータとする（翻訳用）
    # 検索結果をそのまま返却
    refs = where(reading_search: search, :loc.exists => false)
    return refs
  end

  def self.get_word_withloc(s, lat, lon)
    # 語尾ふた文字が共通する言葉を取得
    search = daku_to_sei(s)[-2,2]
    # 地図情報ありのデータとする（地図用）
    # 検索結果をそのまま返却
    refs = where(reading_search: search, :loc.exists => true, :loc => {"$near" => [lat,lon]})
    return refs
  end
  
  def self.get_text(text)
    # YahooAPIで判定した配列から文章を生成・返却する
    ret = []
    text.each do |t|
      if t.pos
        refs = get_word_noloc(t.reading)
        if refs.count > 0
          ref = refs[rand(max=refs.count)]
          t.chg_surface = ref.surface
          t.chg_reading = ref.reading
          t.changed = true
        end
      end
      ret << t
    end
    return ret
  end
end
