class CaseSerializer < ActiveModel::Serializer
  attribute :id
  attribute :status_name, key: :status
  attribute :video_self,  key: :video
  attribute :case_causes, key: :causes

  belongs_to :user
  has_one    :inconvenience
  has_one    :booking
  has_many   :tests
end
