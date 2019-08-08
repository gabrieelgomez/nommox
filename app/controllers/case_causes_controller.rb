class CaseCausesController < InternalController
  before_action :authenticate
  before_action :set_case_cause, only: %i[edit update show destroy]

  def index
    @case_causes = CaseCause.all
    respond_to_formats(:index, @case_causes)
  end

  def new
    @case_cause = CaseCause.new
  end

  def create
    @case_cause = CaseCause.new(case_cause_params)

    if @case_cause.save
      respond_to do |format|
        format.html { redirect_to :case_causes }
        format.json { render json: @case_cause }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @case_cause.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @case_cause.update(case_cause_params)
        format.html { redirect_to @case_cause, notice: 'Case Cause was successfully updated.' }
        format.json { render json: @case_cause, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @case_cause.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to_formats(:show, @case_cause)
  end

  def destroy
    @case_cause.destroy
    respond_to do |format|
      format.html { redirect_to case_causes_url, notice: 'Case Cause was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def case_cause_params
    params.require(:case_cause).permit(:name)
  end

  def set_case_cause
    @case_cause = CaseCause.find_by_id(
                              params.dig(:id)
                            )
  end
end
