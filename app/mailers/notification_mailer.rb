class NotificationMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.notify.subject
  #
  def notify(asesor, case_obj)
    @asesor = asesor
    @case   = case_obj
    @url    = "http://www.nommox.com/cases/#{@case.id}"

    mail(
      to: @asesor.email,
      subject: 'Has sido añadido a un caso'
    )
  end
end
