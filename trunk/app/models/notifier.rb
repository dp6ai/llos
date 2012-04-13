class Notifier < ActionMailer::Base
  def contact(message)
    recipients "info@lloydloom.com, lloswebsite@googlemail.com"
#    recipients "matt.spendlove@gmail.com"

    from       message.email
    subject    message.subject
    body       :message => message
  end
end
