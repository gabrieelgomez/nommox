class Activity < ApplicationRecord
  before_save :set_date

  def parsed_date
    I18n.l(self.date, format: '%A %d, %m %I:%M %p')
    # date.present? ? "Últ. Conexión: #{ }" : ''
  end

  private

  def set_date
    self.date = DateTime.now
  end

end
