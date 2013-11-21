# coding: utf-8
class TranslateController < ApplicationController

  def index
    render 'translate/index'
  end
  
  def show
    p = params["translation"]
    text = Yahooapi.get_text(p)
    @result = Word.get_text(text)
    @cause = p
    render 'translate/index'
  end

end

