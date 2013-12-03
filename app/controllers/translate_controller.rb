# coding: utf-8
class TranslateController < ApplicationController

  def index
    @cause = "閑さや　岩にしみ入る　蝉の声"
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

