# coding: utf-8
class TranslateController < ApplicationController

  def index
    @cause = "いやロボットも一生懸命なのです。でも回せば回すほどイミフー。"
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

