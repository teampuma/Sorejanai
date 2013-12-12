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
    @id = res.id
    @keyword = res.search
    @word = res.result
    @yomigana = Yahooapi.get_hiragana(@word)
    @errorMeg = nil
    @template=" "
    @goods = Rakutenapi.find_goods(@word)
    @counter = Result.all.count
    @point_sore = res.sorejanai
    @tw_text = @keyword + "を検索したら" + @word + "が出てきた。。。"
    # rescue HTTPClient::BadResponseError => e
    # rescue HTTPClient::TimeoutError => e
    render 'itemsearch/index'
  end

  def inc
    # 点数をつけるメソッド。
    res = Result.find(params[:id])
    res.inc(:sorejanai => 10)
    #res.inc(:warukunai => 1)
    result = {'point' => res.sorejanai}
    render json: result
  end

  def autocomplete
    param = params[:keyword]
    words = Word.where(surface: /^#{param}/).limit(5)
    result = []
    words.each do |w|
      result << {'surface' => w.surface}
    end
    render json: result
  end

  private
    def get_one_word
      Word.init
      
      ret = nil
      # 語尾ふた文字が共通する言葉を取得
      hira = Yahooapi.get_hiragana(@keyword)
      refs = Word.get_word(hira)
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
