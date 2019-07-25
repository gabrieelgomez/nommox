class Causes::CaseCauseController < ApplicationController
  before_action :set_case_cause, only: %i[edit update destroy]

  def index
    @case_causes = CaseCause.all
    respond_to_formats(:index, @case_causes)
  end

  def new
    @case_cause = CaseCause.new
  end

  def create
    @text = CaseCause.new(case_cause_params)

    if @text.save
      redirect_to :causes_causes
    else
      redirect_back(fallback_location: :causes_causes_path)
    end
  end

  def edit; end

  def update
    if @case_cause.update!(case_cause_params)
      redirect_to :causes_causes
    else
      redirect_back(fallback_location: :causes_causes_path)
    end
  end

  def show; end

  def destroy
    @case_cause.destroy
    redirect_back(fallback_location: :causes_causes_path)
  end

  private

  def case_cause_params
    params.require(:case_cause).permit(:name)
  end

  def set_case_cause
    @case_cause = CaseCause.find(
                                params.dig(:case_cause_id)
                              )
  end
end
