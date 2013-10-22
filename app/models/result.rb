# coding: utf-8
=begin
 * 検索条件＋結果保存
 *  
 * 定義：
 * 検索条件、検索結果
 * 
=end
class Result
  include Mongoid::Document
  field :search, type: String
  field :result, type: String
end
