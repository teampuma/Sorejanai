# coding: utf-8
require 'csv'

# 削除予定
# DBを初期化するのはやめる（デプロイ時にエラーがおこるから）

# ファイル存在チェック
#path = File.expand_path("db/ContentW.csv")
#CSV.foreach(path) do |row|
#  p row
#  break
#end


# Word_Collectionをクリアする
# CSVファイルを読み込んでWordに格納する
# ひらがなからアルファベットに変換する
