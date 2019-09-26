class CasesController < InternalController
  before_action :authenticate
  before_action :set_case, only: %i[edit update show destroy]

  def index
    @cases = Case.all
    respond_to_formats(:index, @cases)
  end

  def new
    @case = Case.new
  end

  def create
    @case = Case.new(case_params)

    if @case.save
      respond_to do |format|
        format.html { redirect_to :cases }
        format.json { render json: @case }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @case.update(case_params)
        format.html { redirect_to @case, notice: 'Case Cause was successfully updated.' }
        format.json { render json: @case, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    respond_to_formats(:show, @case)
  end

  def destroy
    @case.destroy
    respond_to do |format|
      format.html { redirect_to cases_url, notice: 'Case Cause was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_case
    @case = Case.find_by_id(params.dig(:id))
  end
end
