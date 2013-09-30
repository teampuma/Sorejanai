# coding: utf-8
require 'json'
require 'csv'


# ファイル存在チェック
#path = File.expand_path("db/ContentW.csv")
#CSV.foreach(path) do |row|
#  p row
#  break
#end

c = Mongoid::Config

# 参照
refs = Word.all

refs.each do |ref|
  p ref
end


# 削除
refs.delete

# 作成
Word.create(surface: "test")




# Word_Collectionをクリアする
# CSVファイルを読み込んでWordに格納する
# ひらがなからアルファベットに変換する
