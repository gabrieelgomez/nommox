class CaseStatusController < InternalController
  before_action :authenticate
  before_action :set_case_status, only: %i[edit update show destroy]

  def index
    @case_statuses = CaseStatus.page(params.dig(:page) || 1)
    respond_to_formats(:index, @case_statuses)
  end

  def new
    @case_status = CaseStatus.new
  end

  def create
    @case_status = CaseStatus.new(case_status_params)

    if @case_status.save
      respond_to do |format|
        format.html { redirect_to :case_status_index }
        format.json { render json: @case_status }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @case_status.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @case_status.update(case_status_params)
        format.html { redirect_to @case_status, notice: 'Case Estatus was successfully updated.' }
        format.json { render json: @case_status, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @case_status.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to_formats(:show, @case_status)
  end

  def destroy
    @case_status.destroy
    respond_to do |format|
      format.html { redirect_to case_status_index_url, notice: 'Case Estatus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def case_status_params
    params.require(:case_status).permit(:name)
  end

  def set_case_status
    @case_status = CaseStatus.find_by_id(params.dig(:id))
  end
end
