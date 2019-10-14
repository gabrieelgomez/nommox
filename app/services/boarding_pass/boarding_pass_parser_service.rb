module BoardingPass
  class BoardingPassParserService < ApplicationService

    def initialize(data)
      @data     = CGI::escape(data).gsub('+', '%20')
      @airlines = YAML.load_file("#{Rails.root}/config/airlines.yml")
      @airports = YAML.load_file("#{Rails.root}/config/airports.yml")
    end

    def parse
      response = HTTParty.get("https://www.flighthistorian.com/boarding-pass/json/#{@data}")
      build_response(response)
    end

    def build_response(data)
      temp_hash = Hash.new

      temp_hash[:format]    = data.dig("unique", "mandatory", "1", "raw")&.strip
      temp_hash[:legs]      = data.dig("unique", "mandatory", "5", "raw")&.strip
      temp_hash[:passenger] = data.dig("unique", "mandatory", "11", "raw")&.strip
      temp_hash[:pnr]       = data.dig("repeated")[0].dig("mandatory", "7", "raw")&.strip
      temp_hash[:from]      = find_airport(data.dig("repeated")[0].dig("mandatory", "26", "raw")&.strip)
      temp_hash[:to]        = find_airport(data.dig("repeated")[0].dig("mandatory", "38", "raw")&.strip)
      temp_hash[:airline]   = @airlines.dig(data.dig("repeated")[0].dig("mandatory", "42", "raw")&.strip)
      temp_hash[:flight]    = data.dig("repeated")[0].dig("mandatory", "43", "raw")&.strip
      temp_hash[:date]      = data.dig("repeated")[0].dig("mandatory", "46", "raw")&.strip
      temp_hash[:seat]      = data.dig("repeated")[0].dig("mandatory", "104", "raw")&.strip

      temp_hash
    end

    def find_airport(code)
      @airports.each do |airport|
        return "#{airport['name']} - #{airport['code']}" if airport['code'].upcase.eql?(code)
      end
    end

  end
end
