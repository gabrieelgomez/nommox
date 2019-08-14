class CaseSerializer < ActiveModel::Serializer
  attributes :id, :status, :video_self, :hours_late, :notifications_enabled,
                  :case_causes

  belongs_to :user
  has_one    :inconvenience
  has_one    :booking
  has_many   :tests
  has_many   :tickets
end
