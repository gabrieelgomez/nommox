class RecordSerializer < ActiveModel::Serializer
  attributes :id, :call_sid, :record_url
end
