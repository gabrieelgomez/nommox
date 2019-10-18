class CaseSerializer < ActiveModel::Serializer
  attribute :id
  attribute :status_name,        key: :status
  attribute :video_self,         key: :video
  attribute :case_causes,        key: :causes
  attribute :delayReason,        key: :delayReason
  attribute :cancelTime,         key: :cancelTime
  attribute :overbookingBenefit, key: :overbookingBenefit
  attribute :baggageProblem,     key: :baggageProblem
  attribute :claimForm,          key: :claimForm
  attribute :bills
  attribute :baggageBills,       key: :baggageBills
  attribute :baggageDate,        key: :baggageDate
  attribute :belongingsValue,    key: :belongingsValue
  attribute :valueStatement,     key: :valueStatement

  belongs_to :user
  has_one    :inconvenience
  has_one    :booking
  has_many   :tests
end
