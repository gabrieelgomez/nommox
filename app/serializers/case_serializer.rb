class CaseSerializer < ActiveModel::Serializer
  attributes :id, :incident
  attribute  :status_name, key: :status
  attribute  :parsed_case_causes, key: :causes
  attribute  :tests_names, key: :tests
  attribute  :parsed_companions, key: :companions

  belongs_to :user
  has_many   :flights
end
