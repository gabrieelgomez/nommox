class City < ApplicationRecord
  belongs_to :country
  has_many :provinces, dependent: :destroy
end
