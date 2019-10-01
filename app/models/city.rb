class City < ApplicationRecord
  belongs_to :country
  has_many :provinces, dependent: :destroy
  validates :name, presence: true
end
