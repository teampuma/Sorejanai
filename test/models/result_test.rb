# coding: utf-8
require 'test_helper'

class ResultTest < ActiveSupport::TestCase
  def setup
    refs = Result.all
    refs.delete
    # テストデータの作成
    @res = Result.create(search: "test", result: "test_result")
  end
  
  def teardown
    #refs = Result.all
    #refs.delete
  end

  test "access mongo" do
    test = Result.find(@res._id)
    assert_equal "test", test.search
    assert_equal "test_result", test.result
  end

  test "test inc" do
    test = Result.find(@res._id)
    
    test.inc(:sorejanai => 2)
    test.inc(:warukunai => 4)

    assert_equal 2, test.sorejanai
    assert_equal 4, test.warukunai
  end
  
end

