namespace :send_mail do
  desc "メッセージを定期的にメール送信する"

  def get_body
    # メール本文を作成する

    # メッセージを取得
    msgs = Message.where(sendflg: false)
    
    # メッセージがなかったら終了
    if msgs.count == 0 then
      return ""
    end

    # メール本文作成
    tmp = []
    msgs.each do |msg|
      tmp << msg.postdt.strftime("%Y/%m/%d %H:%M:%S") + " " + msg.message 
      # 送信したメッセージに送信フラグを立てる
      #msg.sendflg = true
      #msg.save
    end
    body = tmp.join("\n")
    return body
  end

  def get_address
    # メールアドレスを取得
    address = []

    admins = Admin.all
    admins.each do |admin|
      address << admin.address
    end

    if address.size == 0 then
      address << "teampuma774@gmail.com"
    end
    
    return address
  end

  task :send => :environment do
    puts "Start send mail."

    body = get_body
    if body == "" then
      puts "End send mail for 0 message."
      exit
    end

    address = get_address

    #メール送信
    
    
    puts "End send mail."
  end
  

end
