# coding: utf-8
class TranslateController < ApplicationController

  def index
    @cause = "卯の花に 兼房見ゆる 白毛かな"
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

