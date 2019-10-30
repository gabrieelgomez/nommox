class CaseSerializer < ActiveModel::Serializer
  attributes :id, :incident
  attributes :date
  attribute  :parsed_case_causes, key: :causes
  attribute  :tests_names, key: :tests
  attribute  :parsed_companions, key: :companions
  attribute  :parsed_status, key: :status

  belongs_to :user
  has_many   :flights
end
