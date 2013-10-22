# coding: utf-8
=begin
 * 楽天APIを使った商品情報検索を格納するモデル
 * 返却されるパラメータはrakutenAPIのドキュメントを参考にすること
 * 
 * デフォルトでJSON返却
=end
require 'active_resource'

class Rakutenapi < ActiveResource::Base
  # Rakuten Definition
  RAKUTEN_APP_ID = "1012622615583035302"
  RAKUTEN_AFFILIATE_ID = "11b23d84.1af290b5.11b23d85.b706ce01"
  RAKUTEN_SERVICE_PATH = "/services/api/IchibaItem/Search/20130805"
  self.site = "https://app.rakuten.co.jp/"

  def self.find_goods(sentence)
    # set parameters
    pm = { :applicationId => RAKUTEN_APP_ID, 
           :affiliateId => RAKUTEN_AFFILIATE_ID,
           :keyword => sentence,
           :imageFlag => 1,         # 画像ありの商品のみ
           :hits => 1,
           :page => 1
          }
    
    # search
    self.find(:one, 
              :from => RAKUTEN_SERVICE_PATH,
              :params => pm )
  end

end
