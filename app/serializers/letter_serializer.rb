class LetterSerializer < ActiveModel::Serializer
  attributes :id, :text

  belongs_to :country
end
