# coding: utf-8
require 'test_helper'
 
class ItemsearchControllerTest  < ActionController::TestCase
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
    # 200を返却
    assert_response(:success)
    # テンプレートが妥当か
    assert_template('itemsearch/index')
    # 入力値がはいっているか
    assert_select('input[value="うどん"]')
  end
end
