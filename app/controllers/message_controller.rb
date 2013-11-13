# coding: utf-8
require "date"
class MessageController < ApplicationController

  def index
    render 'message/index'
  end

  def post
    # メッセージを保存する
    Message.create!(
        message: params["message"],
        postdt: DateTime.now,
        sendflg: false)
    @thx = "ご意見ありがとちゃん！"
    render 'message/index'
  end
end
