# coding: utf-8
require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  def setup
    # テストデータの作成
  end
  
  def teardown
    refs = Word.all
    refs.delete
  end

  test "access mongo" do
    # テストデータの作成
    res = Result.create(search: "test", result: "test_result")
    p res._id
    p Result.find(res._id)
  end
  

end

