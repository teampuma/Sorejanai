# coding: utf-8
class TranslateController < ApplicationController

  def index
    @cause = "俳句や川柳くらいの長さの文章ですと、ソコソコ行けるときもございます。"
    render 'translate/index'
  end
  
  def show
    p = params["translation"]
    text = Yahooapi.get_text(p)
    @result = Word.get_text(text)
    @tw_text = @result
    @cause = p
    render 'translate/index'
  end

end

