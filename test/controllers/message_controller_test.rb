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
    get :index
    # 200を返却
    assert_response(:success)
    # テンプレートが妥当か
    assert_template('message/index')
  end

  test "access_message_post" do
    # message_postにアクセス
    post :post, {:message => "意見のサンプル"}
    # 200を返却
    assert_response(:success)
    # テンプレートが妥当か
    assert_template('message/index')
    # メッセージに格納されているか
    msgs = Message.all
    assert_equal(1, msgs.count)
    msgs.each do |msg|
      assert_equal("意見のサンプル", msg.message)
      assert_equal(false, msg.sendflg)
    end
  end

end
