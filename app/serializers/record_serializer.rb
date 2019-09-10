class RecordSerializer < ActiveModel::Serializer
  attribute :id
  attribute :call_sid,   key: :sid
  attribute :record_url, key: :url
end
