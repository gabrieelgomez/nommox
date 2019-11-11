class SmtpSettingsController < ApplicationController
  before_action :set_smtp_setting

  def index
  end

  def update
    if @smtp_setting.update(smtp_setting_params)
      redirect_to smtp_settings_path, notice: 'Configuración actualizada exitosamente'
    else
      redirect_to smtp_settings_path, notice: 'No hemos podido editar su configuración'
    end
  end

  private

  def set_smtp_setting
    @smtp_setting = SmtpSetting.first
  end

  def smtp_setting_params
    params.require(:smtp_setting).permit(:password)
  end

end
