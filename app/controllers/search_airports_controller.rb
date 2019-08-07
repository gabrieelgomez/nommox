class SearchAirportsController < ApplicationController
  before_action :set_airports

  def search
    query = params.dig(:query)
    @results = Array.new

    @airports.each do |a|
      next unless a['country'].include?(query) || a['city'].include?(query)
      @results.push(build_hash(a))
    end

    respond_to_formats(:search, @results)
  end

  private

  def set_airports
    @airports = YAML.load_file(
      "#{Rails.root}/config/airports.yml"
    )
  end

  def build_hash(data)
    temp_hash = Hash.new
    temp_hash[:code]    = data['code']
    temp_hash[:lat]     = data['lat']
    temp_hash[:lon]     = data['lon']
    temp_hash[:name]    = data['name']
    temp_hash[:display] = "#{data['name']} - #{data['code']}"

    temp_hash
  end

end
