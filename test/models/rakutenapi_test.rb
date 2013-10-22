require 'test_helper'

class RakutenapiTest < ActiveSupport::TestCase

  test "access rakuten return 0" do
    res = Rakutenapi.find_goods("あばらばらばら")
    assert_equal 0, res.count
    assert_equal [], res.Items
  end

  test "access rakuten return gt 1" do
    sleep(1)
    res = Rakutenapi.find_goods("うどん")
    # 検索結果は常に1であること
    assert_equal 1, res.Items.size
    res.Items[0].Item.itemName
  end

  test "rakuten api construct" do
    # p Rakutenapi.new
  end

end
