# coding: utf-8
require 'test_helper'

class WordTest < ActiveSupport::TestCase
  def setup
    # テストデータの作成
    refs = Word.all
    refs.delete
  end
  
  def teardown
    refs = Word.all
    refs.delete
  end

  test "access mongo" do
    # テストデータの作成
    Word.create(surface: "test", reading: "てすど", reading_seion: "てすと", reading_search: "すと", count_hira:3)

    # 参照
    refs = Word.all
    
    # 件数のチェック
    assert_equal(1, Word.count)
    refs.each do |ref|
      # 内容のチェック
      assert_equal("test", ref.surface)
      assert_equal("てすど", ref.reading)
      assert_equal("てすと", ref.reading_seion)
      assert_equal("すと", ref.reading_search)
      assert_equal(3, ref.count_hira)
    end

  end
  
  test "init Word Class" do
    # Wordクラスの初期化=
    # データが格納されていることを確認
    Word.init

    # 参照:語尾がどんorとんのものを取得
    refs = Word.any_in(reading_seion: /とん$/)
    
    # 件数のチェック
    assert_equal(29, refs.count)

    # 参照:語尾がどんorとんのものを取得
    refs = Word.where(reading_search: "とん")
    
    # 件数のチェック
    assert_equal(29, refs.count)

  end

end

