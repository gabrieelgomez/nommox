class CasesController < InternalController
  before_action :authenticate, except: [:update_status, :add_comment]
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
    @case_statuses = CaseStatus.all
    respond_to_formats(:show, @case)
  end

  def destroy
    @case.destroy
    respond_to do |format|
      format.html { redirect_to cases_url, notice: 'Case Cause was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_status
    @case   = Case.find_by_id(params.dig(:case_id))
    @status = CaseStatus.find_by_id(params.dig(:case_status_id))
    @device = Device.find_by_identity(@case.user.email)

    if @case.update(case_status_id: params.dig(:case_status_id))
      render json: true
    end

    message = "Su caso a sido actualizado a: #{@status.name}"

    pusher = Grocer.pusher(
      certificate: "#{Rails.root}/pushcert.pem",      # required,
      gateway: 'gateway.sandbox.push.apple.com',
    )

    notification = Grocer::Notification.new(
      device_token:      @device.token,
      alert:             message,
      badge:             1,
      sound:             "siren.aiff",         # optional
    )

    pusher.push(notification) # return value is the number of bytes sent successfully
  end

  def add_comment
    @case = Case.find_by_id(params.dig(:case_id))

    @comment = @case.comments.new(
      text:    params.dig(:comment),
      user_id: params.dig(:user_id)
    )

    if @comment.save
      render json: true
    end

  end

  private

  def set_case
    @case = Case.find_by_id(params.dig(:id))
  end
end
