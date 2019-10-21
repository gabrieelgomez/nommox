class NotificationMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.notify.subject
  #
  def notify(asesor)
    @asesor = asesor
    mail(
      to: @asesor.email,
      from: 'noreply@nommox.com',
      subject: 'Subject'
    )
  end
end
