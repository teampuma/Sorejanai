require 'test_helper'

class YahooapiTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

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
end
