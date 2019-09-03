# Simple model to handle validation
class CallRequest
  include ActiveModel::Validations
  attr_accessor           :from
  attr_accessor           :to
  validates_presence_of   :from, :to
  validates :from,        :phony_plausible => true
  validates :to, :phony_plausible => true

  def self.new_call_request(from_phone, to_phone)
    from  = from_phone
    to    = to_phone
  end

  def encoded_to_phone
    URI.encode(to)
  end
end
