class Flight < ApplicationRecord

  def date_parsed
    date.strftime('%d-%m-%Y')
  end

end
