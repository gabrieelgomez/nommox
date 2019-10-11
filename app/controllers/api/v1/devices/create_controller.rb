module Api::V1::Devices
  class CreateController < DevicesController

    def create
      @device = Device.find_by_identity(params.dig(:identity))

      if @device.present?
        @device.update(token: params.dig(:token)) unless @device.token.eql?(params.dig(:token))
      else
        @device = Device.create(identity: params.dig(:identity), token: params.dig(:token))
      end
    end

    render json: @device, status: 200
  end
end
