class Fcm
  require 'fcm'

  def self.send_message(devices, message, priority = 'high')
    fcm = FCM.new('AAAAG-dERio:APA91bHcy9uVw-4uelZmzuHj4o7DA6DLWruN9Pm2cbP13W1qq9A46FwvvRidubUI4lUt3PjdtP4jIhdsrlgoHhD9bWa9u0kArRhHWB_tOcbfog_8rOO9PT8l3F3g7By84gKRzohlu174')

    registration_ids = devices # an array of one or more client registration tokens

    message[:priority] = priority

    Rails.logger.info "============fcm options==============="
    Rails.logger.info "#{message}"
    Rails.logger.info "======================================="

    response = fcm.send(registration_ids, message)

    Rails.logger.info "============fcm response==============="
    Rails.logger.info "#{response.as_json}"
    Rails.logger.info "======================================"

    return response
  end

  def self.data_payload (title, body = '', data)
    {
      notification: {
        content_available: true,
        title: title,
        body: body,
        icon: "myicon",
        sound: "default"
      },
      data: data
    }
  end
end
