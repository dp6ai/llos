class Notifier < ActionMailer::Base
  def contact(message)
    #MSP TODO
    #recipients "info@lloydloom.com, lloswebsite@googlemail.com, henryharris@hotmail.co.uk"
    recipients "info@lloydloom.com, lloswebsite@googlemail.com, henryharris@hotmail.co.uk"
    #recipients "patrickjdavenport@gmail.com"

    from       message.email
    subject    message.subject
    body       :message => message
  end
end
