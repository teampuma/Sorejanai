# coding: utf-8
require 'test_helper'
 
class MessageControllerTest  < ActionController::TestCase
  def setup
    @controller = MessageController.new
    refs = Message.all
    refs.delete
  end

  def teardown
    refs = Message.all
    refs.delete
  end

  test "access_message_index" do
    # message_indexにアクセス
    assert_routing '/message', { :controller => "message", :action => "index" }
    # 200を返却
    assert_response(:success)
  end

end
