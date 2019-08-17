class Case < ApplicationRecord
  belongs_to :user
  has_one    :inconvenience, dependent: :destroy
  has_one    :booking, dependent: :destroy
  has_one    :tests, dependent: :destroy, class_name: 'Test'
  has_many   :tickets, dependent: :destroy

  #uploader
  mount_uploader :video_self, AttachmentUploader

  def case_cause_ids_parsed
    self.case_cause_ids.join(', ').split(',').map(&:to_i)
  end

  def case_causes
    CaseCause.where(id: case_cause_ids_parsed)
  end
end
