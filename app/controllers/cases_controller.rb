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
    @case = Case.find_by_id(params.dig(:case_id))
    if @case.update(case_status_id: params.dig(:case_status_id))
      render json: true
    end

    # pusher = Grocer.pusher(
    #   certificate: "#{Rails.root}/cert.pem",      # required,
    #   gateway: 'gateway.sandbox.push.apple.com',
    # )
    #
    # notification = Grocer::Notification.new(
    #   device_token:      "fe15a27d5df3c34778defb1f4f3880265cc52c0c047682223be59fb68500a9a2",
    #   alert:             "Testing Notification From Nommox!",
    #   badge:             42,
    #   sound:             "siren.aiff",         # optional
    # )
    #
    # pusher.push(notification) # return value is the number of bytes sent successfully
    require 'houston'

    apn = ::Houston::Client.production
    apn.certificate = File.read("#{Rails.root}/certificate.pem")

    # An example of the token sent back when a device registers for notifications
    token = '<47be68cf4ad1a541a3ef5aac52bd8fe081b7cc06feb7bc773edfa9b26a323f8c>'

    # Create a notification that alerts a message to the user, plays a sound, and sets the badge on the app
    notification = ::Houston::Notification.new(device: token)
    notification.alert = 'Hello, World!'

    # Notifications can also change the badge count, have a custom sound, have a category identifier, indicate available Newsstand content, or pass along arbitrary data.
    notification.badge = 57
    notification.sound = 'sosumi.aiff'
    notification.content_available = true
    notification.mutable_content = true

    # And... sent! That's all it takes.
    apn.push(notification)
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
