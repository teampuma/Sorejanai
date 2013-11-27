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
    assert_equal(30, refs.count)

    # 参照:語尾がどんorとんのものを取得
    refs = Word.where(reading_search: "とん")
    
    # 件数のチェック
    assert_equal(30, refs.count)

  end

  test "daku_to_sei" do
    AIU = "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん"
    assert_equal AIU, Word.daku_to_sei(AIU)
    assert_equal "はひふへほ", Word.daku_to_sei("ぱぴぷぺぽ")
    assert_equal "かきくけこ", Word.daku_to_sei("がぎぐげご")
    assert_equal "さしすせそ", Word.daku_to_sei("ざじずぜぞ")
    assert_equal "たちつてと", Word.daku_to_sei("だぢづでど")
    assert_equal "はひふへほ", Word.daku_to_sei("ばびぶべぼ")
    assert_equal "ゃゅょぁぃぅぇぉ", Word.daku_to_sei("ゃゅょぁぃぅぇぉ")
  end
  
  test "get text print" do
    Word.init
    
    w1 = Translation.new("surface" => "饂飩", "reading" => "うどん", "pos" => true)
    w2 = Translation.new("surface" => "と", "reading" => "と", "pos" => false)
    w3 = Translation.new("surface" => "牛丼", "reading" => "ぎゅうどん", "pos" => true)
    tmps = [w1,w2,w3]
    ret = Word.get_text(tmps)
    assert true, ret[0].changed
    assert true, ret[2].changed
    assert "と", ret[1].reading
    
  end

  test "get no loc data test" do
    Word.init
    # refs = Word.all.near(:loc => [100,200])
    # refs = Word.where(reading_search: "とん").near(:loc => [100,200])
    refs = Word.get_word_noloc("どん")
    assert_equal(28, refs.count)
    # p Word.all.near(:loc => [100,200])
  end
  
  test "get loc data test" do
    refs = Word.getloc("東京")
  end

end

