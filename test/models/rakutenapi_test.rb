require 'test_helper'

class RakutenapiTest < ActiveSupport::TestCase

  test "access rakuten return 0" do
    res = Rakutenapi.find_by_sentence("あばらばらばら")
    assert_equal 0, res.count
    assert_equal [], res.Items
  end

  test "access rakuten return gt 1" do
    res = Rakutenapi.find_by_sentence("うどん")
    # 検索結果は常に1であること
    assert_equal 1, res.Items.size
    # p res
  end

end
