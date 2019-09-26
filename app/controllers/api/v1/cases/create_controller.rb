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
      password = user_params.dig(:email).split('@').first + 'nommox'
      data     = { password: password, role_id: 1 }
      user     = User.where(email: params.dig(:user, :email))
                    .first_or_create(user_params.merge(data))

      user
    end

    def create_case(user_id)
      @case = Case.new(case_params.merge(user_id: user_id))

      if @case.save
        create_tickets(@case.id)
        create_flights(@case.id)
        create_tests(@case.id)
        create_inconvenience(@case.id)
        create_booking(@case.id)

        render json: @case, status: 200
      else
        render json: @case.errors, status: 500
      end
    end

    def create_tickets(case_id)
      byebug
      return if params.dig(:ticket).nil?
      @ticket = Ticket.new(ticket_params&.merge(case_id: case_id))

      unless @ticket.save
        render json: @ticket.errors, status: 500
      end
    end

    def create_tests(case_id)
      if params.dig(:test).nil?
        @test = Test.create(case_id: case_id)
      else
        @test = Test.new(test_params.merge(case_id: case_id))

        unless @test.save
          render json: @test.errors, status: 500
        end
      end
    end

    def create_inconvenience(case_id)
      return if params.dig(:inconvenience).nil?
      @inconvenience = Inconvenience.new(inconvenience_params.merge(case_id: case_id))

      unless @inconvenience.save
        render json: @inconvenience.errors, status: 500
      end
    end

    def create_booking(case_id)
      return if params.dig(:booking).nil?
      @booking = Booking.new(booking_params.merge(case_id: case_id))

      if @booking.save
        create_companions(@booking)
      else
        render json: @booking.errors, status: 500
      end
    end

    def create_companions(booking)
      companions = params.dig(:companions)
      return if companions.nil?

      companions.each do |companion|
        booking.companions.create(
          names:                   companion[:name],
          surnames:                companion[:surname],
          identification_document: companion[:identification_document],
          passport:                companion[:passport],
        )
      end
    end

    def create_flights(case_id)
      flights = params.dig(:flights)
      return if flights.nil?

      flights.each do |flight|
        Flight.create!(
          airline:                flight[:airline],
          departure_airport_name: flight[:departure],
          arrival_airport_name:   flight[:arrival],
          hour:                   flight[:hour],
          date:                   flight[:date],
          flight_number:          flight[:flight_number],
          case_id:                case_id
        )
      end
    end
  end
end
