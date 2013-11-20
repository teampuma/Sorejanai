require 'test_helper'

class YahooapiTest < ActiveSupport::TestCase

  test "access yahoo" do
    res = Yahooapi.find_by_sentence("漢字")
    assert_equal("かんじ", res.ma_result.word_list.word.reading)
    res = Yahooapi.find_by_sentence("カタカナ")
    assert_equal("かたかな", res.ma_result.word_list.word.reading)
    res = Yahooapi.find_by_sentence("ひらがな")
    assert_equal("ひらがな", res.ma_result.word_list.word.reading)
  end

  test "Change to Hiragana" do
    res = Yahooapi.get_hiragana("")
    assert_equal("なし", res)
    res = Yahooapi.get_hiragana("漢字")
    assert_equal("かんじ", res)
    res = Yahooapi.get_hiragana("庭には二羽ニワトリがいる")
    assert_equal("にわ", res)
  end
  
  test "check Text" do
    res = Yahooapi.get_text("文章でコミュニケーションを取る")
    assert_equal(5, res.count)
    assert_equal("文章", res[0].surface)
    assert_equal("ぶんしょう", res[0].reading)
    assert_equal(true, res[0].pos)
  end
end
