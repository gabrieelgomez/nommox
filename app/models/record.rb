class Record < ApplicationRecord
  validates_presence_of :call_sid, :record_url
end
