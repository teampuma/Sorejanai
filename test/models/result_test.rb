# coding: utf-8
require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  def setup
    # テストデータの作成
    @res = Result.create(search: "test", result: "test_result")
  end
  
  def teardown
    refs = Result.all
    refs.delete
  end

  test "access mongo" do
    test = Result.find(@res._id)
    assert_equal "test", test.search
    assert_equal "test_result", test.result
  end
  
end

