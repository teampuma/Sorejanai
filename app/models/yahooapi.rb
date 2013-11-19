# coding: utf-8
=begin
 * 日本語形態素解析APIを使った漢字→ひらがな変換
 * 返却されるパラメータはYahooAPIのドキュメントを参考にすること
 * 
 * 意味のある最初の単語のみひらがなで返却する
 * 「庭には二羽ニワトリがいる」→「にわ」
 * 形態素解析なので返却がないという事は考えにくいが、０件だったら決まった文言を返却する
=end
require 'active_resource'

class Yahooapi < ActiveResource::Base
  # Yahoo Definition
  YAHOO_APP_ID = ENV['YAHOO_APP_ID']
  self.site = "http://jlp.yahooapis.jp/"

  class Format
    # XMLをJSON風に返却するためのオーバーライド
    include ActiveResource::Formats::XmlFormat
  end
  
  self.format = Format.new
  
  def self.find_by_sentence(sentence)
    # set parameters
    pm = { :appid => YAHOO_APP_ID, :sentence => sentence }
    
    # search
    self.find(:one, 
              :from => '/MAService/V1/parse',
              :params => pm )
  end
  
  def self.get_hiragana(s)
    # 漢字などからひらがなを返却する(単語)

    res = find_by_sentence(s)
    count = res.ma_result.total_count.to_i
    if count == 0 then
      # ヒットしない場合
      return "なし"
    elsif count == 1 then
      # 1件の場合（単語）はよみがなを返却
      return res.ma_result.word_list.word.reading
    else
      # 複数の場合（文章）は最初のよみがなを返却
      return res.ma_result.word_list.word[0].reading
    end
  end
  
  def self.get_text(s)
    # 文章＋ひらがな＋名詞かどうか返却
    ret = []
    res = find_by_sentence(s)
    res.ma_result.word_list.word.each do |w|
      tmp = {"surface" => w.surface, 
        "reading" => w.reading, 
        "pos" => w.pos == "名詞" ? true : false}
      ret.append(tmp)
    end
    return ret
  end
end
