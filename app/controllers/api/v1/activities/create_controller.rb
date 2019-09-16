module Api::V1::Activities
  class CreateController < ActivityController

    def create
      @activity = Activity.find_by_identity(params.dig(:activity, :identity))

      if @activity.present?
        @activity.update(activity_params)
      else
        @activity = Activity.create(activity_params)
      end
    end

  end
end
