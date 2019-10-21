class SendAsesorNotificationJob < ApplicationJob
  queue_as :default

  def perform(asesor_id)
    asesor = User.asesors.find_by_id(asesor_id)
    NotificationMailer.notify(asesor).deliver_now
  end
end
