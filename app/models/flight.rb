class Flight < ApplicationRecord

  def hour
    date&.strftime('%H:%M') || '00:00'
  end
end
