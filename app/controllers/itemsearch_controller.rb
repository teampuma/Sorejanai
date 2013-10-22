# coding: utf-8
class ItemsearchController < ApplicationController
  @@g_goods = nil
  
  def index
    @@g_goods = nil
    render 'itemsearch/index'
  end

  def search
    # 商品の初期化
    @@g_goods = nil

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
    @errorMeg = nil
    @template=" "
    if @@g_goods == nil then
      @@g_goods = Rakutenapi.find_goods(@word)
    end
    @goods = @@g_goods
    # rescue HTTPClient::BadResponseError => e
    # rescue HTTPClient::TimeoutError => e
    render 'itemsearch/index'
  end

  private
    def get_one_word
      ret = nil
      # 語尾ふた文字が共通する言葉を取得
      hira = Yahooapi.get_hiragana(@keyword)
      search = /#{make_search_str(hira, 2)}$/
      # 検索して、複数件の場合ランダムに返却
      refs = Word.any_in(reading_seion: search)
      if refs.count == 0 then
        # なかったら梨
        ret = "ナシ"
        @@g_goods = Rakutenapi.find_goods(ret)
        return ret
      end
      
      # 言葉から商品を検索して、ヒットするまで回す
      count = 0
      until count > 0
        ret = refs[rand(max=refs.count)].surface
        if count > 5 then
          # 5回検索してなかったら諦める
          ret = "ナシ"
        end
        @@g_goods = Rakutenapi.find_goods(ret)
        count = @@g_goods.count
      end
      return ret
    end

end
