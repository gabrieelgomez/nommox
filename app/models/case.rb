class Case < ApplicationRecord
  belongs_to :user
  belongs_to :asesor, class_name: 'User', foreign_key: :asesor_id, optional: true
  has_many   :flights,       dependent: :destroy
  has_one    :inconvenience, dependent: :destroy
  has_one    :tests,         dependent: :destroy, class_name: 'Test'
  belongs_to :status,        dependent: :destroy, class_name: 'CaseStatus', foreign_key: 'case_status_id', optional: true
  has_many   :comments,      dependent: :destroy
  has_many   :companions,      dependent: :destroy

  #uploader
  mount_uploader :video_self, AttachmentUploader

  def incident
    incident = flights.find_by_id(incident_id)

    return nil if incident.nil?

    {
      from: incident.departure_airport_name,
      to:   incident.arrival_airport_name,
      date: incident.date.strftime('%d-%m-%Y'),
      hour: incident.hour,
      airline: incident.airline,
      number: incident.flight_number,

    }
  end

  def tests_names
    tests.names
  end

  def case_cause_ids_parsed
    self.case_cause_ids.join(', ').split(',').map(&:to_i)
  end

  def parsed_case_causes
    CaseCause.where(id: case_cause_ids_parsed)&.pluck(:name)&.split('')&.join(', ')
  end

  def case_causes
    CaseCause.where(id: case_cause_ids_parsed)
  end

  def status_name
    status&.name || ''
  end

  def parsed_companions
    temp_hash = Array.new
    companions.each do |companion|
      cp = {
        names: companion.names,
        surnames: companion.surnames,
        identification: companion.identification_document,
        passport: companion.passport
      }

      temp_hash.push(cp)
    end

    temp_hash
  end

end
