# coding: utf-8
=begin
 * 一言メッセージ
 *  
 * 定義：
 * メッセージ、投稿時間、送信フラグ
 * 
=end
class Message
  include Mongoid::Document
  field :message, type: String
  field :postdt, type: DateTime
  field :sendflg, type: Boolean
end
