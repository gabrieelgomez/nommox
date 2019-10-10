module Api::V1
  class Devices::DevicesController < ApiController

    private

    def set_device
      @device = Device.find_by_identity(params.dig(:identity))
    end

  end
end
