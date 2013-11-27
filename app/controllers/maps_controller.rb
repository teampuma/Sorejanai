class MapsController < ApplicationController
  before_action :set_map, only: [:show, :edit, :update, :destroy]

  # GET /maps
  # GET /maps.json
  def index
    s = ""
    getloc(s)
  end

  def search
    @keyword = params['keyword']
    getloc(@keyword)
    render 'maps/index'
  end
  
  private
    def getloc(s)
      #まず検索文言の緯度経度
      l = Word.getloc(s)
      if l == nil then
        return
      end
      # 語尾ふた文字が共通する言葉を取得
      hira = Yahooapi.get_hiragana(s)
      refs = Word.get_word_withloc(hira, l[0], l[1])
      @hash = Gmaps4rails.build_markers(refs) do |word, marker|
        # 0,0はゴミデータなので破棄する
        next if [word.loc[1], word.loc[0]] == [0, 0]
        marker.lat word.loc[1]
        marker.lng word.loc[0]
        marker.infowindow word.surface
      end
    end
end
