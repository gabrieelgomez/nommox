class Booking < ApplicationRecord
  belongs_to :case
  has_many   :companions, dependent: :destroy
end
