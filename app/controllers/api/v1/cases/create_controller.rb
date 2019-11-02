module Api::V1::Cases
  class CreateController < CasesController
    def create
      @user = find_or_create_user
      if @user.valid?
        create_case(@user.id)
      else
        render json: @user.errors, status: 500
      end
    end

    private

    def find_or_create_user
      password = params.dig(:user, :email).split('@').first + 'nommox'
      user     = User.find_by_email(params.dig(:user, :email))

      if user.present?
        user.update(
          name:        params.dig(:user, :name) || user.name,
          email:       params.dig(:user, :email) || user.email,
          phone:       params.dig(:user, :phone) || user.phone,
          country_id:  params.dig(:user, :country) || user.country_id,
          city_id:     params.dig(:user, :city) || user.city_id,
          province_id: params.dig(:user, :province) || user.province_id,
        )
      else
        user = User.create(
          name:        params.dig(:user, :name),
          email:       params.dig(:user, :email),
          phone:       params.dig(:user, :phone),
          country_id:  params.dig(:user, :country),
          city_id:     params.dig(:user, :city),
          province_id: params.dig(:user, :province),
          password:    password,
          role_id:     4
        )
      end

      user
    end

    def create_case(user_id)
      @case = Case.new(
        video_self:         params.dig(:case, :video),
        hours_late:         params.dig(:case, :hours),
        case_cause_ids:     params.dig(:case, :caseCauseIds),
        delayReason:        params.dig(:case, :delayReason),
        cancelTime:         params.dig(:case, :cancelTime),
        overbookingBenefit: params.dig(:case, :overbookingBenefit),
        baggageProblem:     params.dig(:case, :baggageProblem),
        claimForm:          params.dig(:case, :claimForm),
        bills:              params.dig(:case, :bills),
        baggageBills:       params.dig(:case, :baggageBills),
        baggageDate:        params.dig(:case, :baggageDate),
        belongingsValue:    params.dig(:case, :belongingsValue),
        valueStatement:     params.dig(:case, :valueStatement),
        user_id:            user_id
      )

      if @case.save
        create_flights(@case.id)
        create_tests(@case.id)
        create_inconvenience(@case.id)
        create_companions(@case.id)

        render json: { id: @case.id }, status: 200
      else

        render json: @case.errors, status: 500
      end
    end

    def create_tests(case_id)
      if params.dig(:test).nil?
        @test = Test.create(case_id: case_id)
      else
        @test = Test.new(
          videos:    params.dig(:test, :videos),
          documents: params.dig(:test, :documents),
          images:    params.dig(:test, :images),
          voices:    params.dig(:test, :voices),
          case_id:   case_id
        )

        unless @test.save
          render json: @test.errors, status: 500
        end
      end
    end

    def create_inconvenience(case_id)
      return if params.dig(:inconvenience).nil?

      @inconvenience = Inconvenience.new(
        lost_connection: params.dig(:inconvenience, :connection),
        lost_event:      params.dig(:inconvenience, :event),
        description:     params.dig(:inconvenience, :description),
        image:           params.dig(:inconvenience, :image),
        case_id:         case_id
      )

      unless @inconvenience.save
        render json: @inconvenience.errors, status: 500
      end
    end

    def create_companions(case_id)
      companions = params.dig(:companions)
      return if companions.nil?

      companions.each do |companion|
        Companion.create(
          names:                   companion[:names],
          surnames:                companion[:surnames],
          identification_document: companion[:identification],
          back:                    companion[:back],
          passport:                companion[:passport],
          case_id:                 case_id
        )
      end
    end

    def create_flights(case_id)
      flights = params.dig(:flights)
      return if flights.nil?

      flights.each do |flight|
        Flight.create!(
          airline:                flight[:airline],
          departure_airport_name: flight[:from],
          arrival_airport_name:   flight[:to],
          hour:                   flight[:hour],
          date:                   flight[:date],
          flight_number:          flight[:number],
          case_id:                case_id
        )
      end

      associate_incident(case_id)
    end

    def associate_incident(case_id)
      incident = params.dig(:incident)
      @case = Case.find_by_id(case_id)

      return if @case.nil? || incident.nil?

      flight = @case&.flights&.find_by_flight_number(incident[:number])
      @case.update(incident_id: flight.id)
    end

  end
end
