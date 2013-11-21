module TranslateHelper
  
  def show_translation(res)
    # 翻訳結果をいい感じに表示するメソッド
    if res == nil
      return ""
    end
    
    ret = ""
    res.each do |r|
      if r.changed
        ret = ret + content_tag(:b, r.chg_surface)
      else
        ret = ret + r.surface
      end
    end
    
    return raw(ret)
  end
  
end
