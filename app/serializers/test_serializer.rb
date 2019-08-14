class TestSerializer < ActiveModel::Serializer
  attributes :id, :images, :videos, :documents, :voices
end
