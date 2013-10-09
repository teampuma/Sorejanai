class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def make_search_str(s, count)
    # 文字sの後ろcout数だけ取得する
    # 濁点、半濁点を考慮するため
    # ひらがなの濁音を清音に変換する
    daku = "がぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽ"
    sei = "かきくけこさしすせそたちつてとはひふへほはひふへほ"

    ret = s[count*-1, count]
    for i in 0...daku.size
      ret = ret.gsub(daku[i], sei[i])
    end
    return ret
  end
  
end
