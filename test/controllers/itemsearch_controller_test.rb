# coding: utf-8
require 'test_helper'
 
class ItemsearchControllerTest  < ActionController::TestCase
  def setup
    # テストデータの作成
    @test = Result.create(search: "test", result: "test_result")
  end

  def teardown
    refs = Result.all
    refs.delete
  end

  test "access_index" do
    # indexにアクセス
    post(:index)
    # 200を返却
    assert_response(:success)
    # テンプレートが妥当か
    assert_template('itemsearch/index')
  end

  test "access_search" do
    # searchにpost
    post(:search, {:keyword => "うどん"})
    # 302(Redirect)を返却
    assert_response(:redirect)
  end
  
  test "access_show" do
    # show get
    get(:show, {:pid => @test._id})
    # 200を返却
    assert_response(:success)
    # テンプレートが妥当か
    assert_template('itemsearch/index')
    # 入力値がはいっているか
    assert_select('input[value="test"]')
  end
end
