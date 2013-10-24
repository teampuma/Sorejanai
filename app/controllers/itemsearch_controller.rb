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
    @errorMeg = nil
    @template=" "
    @goods = Rakutenapi.find_goods(@word)
    # rescue HTTPClient::BadResponseError => e
    # rescue HTTPClient::TimeoutError => e
    render 'itemsearch/index'
  end

  private
    def get_one_word
      Word.init
      
      ret = nil
      # 語尾ふた文字が共通する言葉を取得
      hira = Yahooapi.get_hiragana(@keyword)
      search = Word.daku_to_sei(hira)[-2,2]
      # 検索して、複数件の場合ランダムに返却
      refs = Word.where(reading_search: search)
      if refs.count == 0 then
        # なかったら梨
        ret = "ナシ"
        return ret
      end
      
      # 言葉から商品を検索して、ヒットするまで回す
      count = 0
      goods = nil
      until count > 0
        ret = refs[rand(max=refs.count)].surface
        if count > 5 then
          # 5回検索してなかったら諦める
          ret = "ナシ"
        end
        goods = Rakutenapi.find_goods(ret)
        count = goods.count
      end
      return ret
    end

end
