class Activity < ApplicationRecord
  before_save :set_date

  def parsed_date
    date = self.date
    parsed_date = I18n.l(self.date, format: '%A %d, %m %I:%M %p')
    [date, parsed_date]
  end

  private

  def set_date
    self.date = DateTime.now
  end

end
