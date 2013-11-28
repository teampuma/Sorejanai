module TranslateHelper
  
  def show_translation(res)
    # 翻訳結果をいい感じに表示するメソッド
    if res == nil
      return ""
    end
    
    ret = ""
    res.each do |r|
      if r.changed
        ret = ret + content_tag(:ruby) { content_tag(:rb, content_tag(:b, r.chg_surface ) ) + content_tag(:rt, r.chg_reading ) }
      else
        ret = ret + r.surface
      end
    end
    
    return raw(ret)
  end
  
end
