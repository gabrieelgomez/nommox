module Api::V1
  class Activities::ActivityController < ApiController

    private

    def activity_params
      params.require(:activity).permit(:identity, :channel, :token)
    end

    def set_activity
      @activity = Activity.find_by_identity(params.dig(:identity)) || {}
    end
  end
end
