module Notifications
  class NotificationsService < ApplicationService

    def initialize(token, message)
     @token    = token
     @message  = message
    end

    def send
      return if @token.nil?

      pusher = Grocer.pusher(
        certificate: "#{Rails.root}/pushcert.pem",      # required,
        gateway: 'gateway.push.apple.com',
      )

      notification = Grocer::Notification.new(
        device_token: @token,
        alert:        @message,
        badge:        1,
        sound:        "siren.aiff",         # optional
      )

      pusher.push(notification) # return value is the number of bytes sent successfully
    end
  end
end
