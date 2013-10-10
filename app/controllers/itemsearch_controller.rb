# coding: utf-8
class ItemsearchController < ApplicationController
  def index
    render 'itemsearch/index'
  end

  def search
    @keyword = params['keyword']
    httpClient = HTTPClient.new

    @jsonData = nil
    @errorMeg = nil
    @word = nil
    begin
      count = 0
      until count > 0
        @word=get_one_word
        data = httpClient.get_content('https://app.rakuten.co.jp/services/api/IchibaItem/Search/20130805', {
            'applicationId' => '1012622615583035302',
            'affiliateId'   => '11b23d84.1af290b5.11b23d85.b706ce01',
            'keyword'       => @word
        })
        @jsonData = JSON.parse data
        count = @jsonData['count']
      end
=begin
      @roman= @keyword.to_roman
      @selectVowel=@roman.split("").select {|item| item == "a" || item == "i" || item == "u" || item == "e" || item == "o" || item == "n" }
      @vowel=@selectVowel.join
      @hiragana=@vowel.to_hiragana
=end
      @jsonData
      @template="相・対・性・うどん

座標変換したらばプロトン

相・対・性・うどん

光の早さで時間がロンドン

量子がもつれて中華丼

かわいいあのこはオートマトン

ところでうな丼

はたしてバリトン

いかにもおいどん

ひるあんどん


ご利用いただきマジ感謝（ ゜∀゜ ）"
    rescue HTTPClient::BadResponseError => e
    rescue HTTPClient::TimeoutError => e
    end

    render 'itemsearch/index'
  end

  private
    def get_one_word
      Word.init
      # 語尾ふた文字が共通する言葉を取得
      search = /#{make_search_str(@keyword, 2)}$/
      # 検索して、複数件の場合ランダムに返却
      refs = Word.any_in(reading_seion: search)
      if refs.count == 0 then
        return "ナシ"        
      end
      return refs[rand(max=refs.count)].surface
    end

end
