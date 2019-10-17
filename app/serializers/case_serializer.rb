class CaseSerializer < ActiveModel::Serializer
  attribute :id
  attribute :status_name, key: :status
  attribute :video_self,  key: :video
  attribute :case_causes, key: :causes
  attributes :delayReason, :cancelTime, :overbookingBenefit, :baggageProblem,
             :claimForm, :bills, :baggageBills, :baggageDate, :belongingsValue,
             :valueStatement

  belongs_to :user
  has_one    :inconvenience
  has_one    :booking
  has_many   :tests
end
