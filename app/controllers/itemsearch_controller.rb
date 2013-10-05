# coding: utf-8
class ItemsearchController < ApplicationController
  def index
    render 'itemsearch/index'
  end

  def search
    @keyword = params['keyword']
    httpClient = HTTPClient.new

    @jsonData = nil
    @errorMeg = nil

    begin
      data = httpClient.get_content('https://app.rakuten.co.jp/services/api/IchibaItem/Search/20130805', {
          'applicationId' => '1012622615583035302',
          'affiliateId'   => '11b23d84.1af290b5.11b23d85.b706ce01',
          'keyword'       => @keyword
      })
      @roman= @keyword.to_roman
      @selectVowel=@roman.split("").select {|item| item == "a" || item == "i" || item == "u" || item == "e" || item == "o" || item == "n" }
      @vowel=@selectVowel.join
      @hiragana=@vowel.to_hiragana
      @jsonData = JSON.parse data
      p @jsonData
    rescue HTTPClient::BadResponseError => e
    rescue HTTPClient::TimeoutError => e
    end

    render 'itemsearch/index'
  end
end
