# coding: utf-8
=begin
 * 管理者情報
 *  
 * 定義：
 * アドレス
 * 
=end
class Admin
  include Mongoid::Document
  field :address, type: String
end
