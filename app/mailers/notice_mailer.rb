class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_facebook.subject
  #
  def sendmail_facebook(facebook)
    @facebook = facebook

    mail to: "toshiaki.ikeda.study@gmail.com",
         subject: '【Achieve】トピックが投稿されました'
  end
end
