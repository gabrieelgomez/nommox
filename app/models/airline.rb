class Airline < ApplicationRecord
  validates_presence_of :name, :phone
  belongs_to :country
end
