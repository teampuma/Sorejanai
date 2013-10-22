# coding: utf-8
class ItemsearchController < ApplicationController
  def index
    render 'itemsearch/index'
  end

  def search
    # 検索文言と結果の文言をDBに登録
    @keyword = params['keyword']
    @word=get_one_word
    res = Result.create(search: @keyword, result: @word)
    
    # 検索を参照する画面にリダイレクト　IDを渡す
    redirect_to :action => "show" , :pid => res._id
  end

  def show
    # 検索を参照するメソッド
    # リダイレクトだけでなく、pid指定で結果を返す
    res = Result.find(params["pid"])
    @keyword = res.search
    @word = res.result
    httpClient = HTTPClient.new

    @jsonData = nil
    @errorMeg = nil
    @template=" "
    begin
      count = 0
      until count > 0
        @word=get_one_word
        data = httpClient.get_content('https://app.rakuten.co.jp/services/api/IchibaItem/Search/20130805', {
            'applicationId' => '1012622615583035302',
            'affiliateId'   => '11b23d84.1af290b5.11b23d85.b706ce01',
            'keyword'       => @word,
            'hits'          => 1,
            'page'          => 1
        })
        @jsonData = JSON.parse data
        count = @jsonData['count']
      end
    rescue HTTPClient::BadResponseError => e
    rescue HTTPClient::TimeoutError => e
    end
    render 'itemsearch/index'
  end

  private
    def get_one_word
      Word.init
      # 語尾ふた文字が共通する言葉を取得
      hira = Yahooapi.get_hiragana(@keyword)
      search = /#{make_search_str(hira, 2)}$/
      # 検索して、複数件の場合ランダムに返却
      refs = Word.any_in(reading_seion: search)
      if refs.count == 0 then
        return "ナシ"        
      end
      return refs[rand(max=refs.count)].surface
    end

end
