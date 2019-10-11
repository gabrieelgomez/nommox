class InconvenienceSerializer < ActiveModel::Serializer
  attributes :id,  :description
  attribute :lost_connection, key: :connection
  attribute :lost_event, key: :event
  attribute :image
end
