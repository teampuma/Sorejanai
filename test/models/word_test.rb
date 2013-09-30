# coding: utf-8
require 'test_helper'

class WordTest < ActiveSupport::TestCase
  def setup
    # テストデータの作成
    Word.create(surface: "test")
  end
  
  def teardown
    # テストデータの削除
    refs = Word.all
    # 削除
    refs.delete
  end

  test "find a data" do
    c = Mongoid::Config
    
    # 参照
    refs = Word.all
    
    # 件数のチェック
    assert_equal(1, refs.count)
    refs.each do |ref|
      # 内容のチェック
      assert_equal("test", ref.surface)
    end
  end
end

