class Case < ApplicationRecord
  belongs_to :user
  has_one    :inconvenience, dependent: :destroy
  has_one    :booking, dependent: :destroy
  has_one    :tests, dependent: :destroy, class_name: 'Test'
  has_many   :tickets, dependent: :destroy
end
