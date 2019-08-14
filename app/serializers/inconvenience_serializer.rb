class InconvenienceSerializer < ActiveModel::Serializer
  attributes :id, :lost_connection, :lost_event, :description, :image
end
