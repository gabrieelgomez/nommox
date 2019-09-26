class CaseStatus < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
