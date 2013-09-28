# coding: utf-8
=begin
  mecabの辞書ファイルから作成されるCollection
  mecabの構成は以下の通り
 工藤,1223,1223,6058,名詞,固有名詞,人名,名,*,*,くどう,クドウ,クドウ  
 表層形,左文脈ID,右文脈ID,コスト,品詞,品詞細分類1,品詞細分類2,品詞細分類3,活用形,活用型,原形,読み,発音

 表層形、品詞、品詞細分類1-3、原型、読み、発音とアルファベットを対象とする
 アルファベットは格納するときに変換する
=end
class Word
  include Mongoid::Document
  field :surface, type: String
  field :word_class, type: String
  field :word_class_detail1, type: String
  field :word_class_detail2, type: String
  field :word_class_detail3, type: String
  field :original, type: String
  field :reading, type: String
  field :pronunciation, type: String
  field :alphabet, type: String
end
