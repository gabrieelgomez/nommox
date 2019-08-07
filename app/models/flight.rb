class Flight < ApplicationRecord
  belongs_to :airline

  def hour
    date.strftime('%H:%M')
  end
end
