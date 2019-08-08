class Flight < ApplicationRecord
  belongs_to :airline

  def hour
    date&.strftime('%H:%M') || '00:00'
  end
end
