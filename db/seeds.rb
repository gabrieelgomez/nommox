This file should contain all the record creation needed to seed the database with its default values.
The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Examples:

  movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
  Character.create(name: 'Luke', movie: movies.first)

#create roles
[:super_admin, :admin, :asesor, :default].each do |role_name|
  Role.create(name: role_name)

  puts "Role #{role_name} has been created"
end

col_country  = Country.create(name: 'Colombia')
colombia     = YAML.load_file("#{Rails.root}/config/countries/colombia.yml")

colombia.each do |location|
  city = col_country.cities.create(name: location['departamento'])

  location['ciudades'].each do |c|
    city.provinces.create(name: c)
  end
end

puts "Colombia countries and provinces has been created"

mex_country  = Country.create(name: 'México')
mexico       = YAML.load_file("#{Rails.root}/config/countries/mexico.yml")

mexico.each do |ciudad, provincias|
  city = mex_country.cities.create(name: ciudad)

  provincias.each do |p|
    city.provinces.create(name: p)
  end
end

puts "México countries and provinces has been created"

bra_country  = Country.create(name: 'Brasil')
brasil       = YAML.load_file("#{Rails.root}/config/countries/brasil.yml")

brasil['estados'].each do |location|
  city = bra_country.cities.create(name: location['nome'])

  location['cidades'].each do |p|
    city.provinces.create(name: p)
  end
end

puts "Brasil countries and provinces has been created"

chile_country  = Country.create(name: 'Chile')
chile          = YAML.load_file("#{Rails.root}/config/countries/chile.yml")

chile.each do |location|
  location['provincias'].each do |province|
    city = chile_country.cities.create(name: province['name'])

    province['comunas'].each do |c|
      city.provinces.create(name: c['name'])
    end
  end
end

puts "Chile countries and provinces has been created"

peru_country   = Country.create(name: 'Peru')
peru_districts = YAML.load_file("#{Rails.root}/config/countries/peru_districts.yml")
peru_provinces = YAML.load_file("#{Rails.root}/config/countries/peru_provinces.yml")

peru_districts.each do |location|
  city      = peru_country.cities.create(name: location['name'])
  provinces = peru_provinces.select { |p| p['region_id'].eql?(location['id']) }

  provinces.each do |province|
    city.provinces.create(name: province['name'])
  end
end

puts "Peru countries and provinces has been created"

Country.create(name: 'Estados Unidos')

#create airlines
airlines = [
  {
    "name": "America Airlines",
    "phone": "+18004337300",
    "coutry_id": 6
  },
  {
    "name": "Avianca",
    "phone": "+18002842622",
    "coutry_id": 6
  },
  {
    "name": "BahamasAir",
    "phone": "+18002224262",
    "coutry_id": 6
  },
  {
    "name": "British Airways",
    "phone": "+18002479297",
    "coutry_id": 6
  },
  {
    "name": "Caribbean Airlines",
    "phone": "+18005382942",
    "coutry_id": 6
  },
  {
    "name": "Cayman Airways",
    "phone": "+18004229626",
    "coutry_id": 6
  },
  {
    "name": "Copa Airlines",
    "phone": "+18003592672",
    "coutry_id": 6
  },
  {
    "name": "Delta Airlines",
    "phone": "+18002211212",
    "coutry_id": 6
  },
  {
    "name": "Iberia",
    "phone": "+18007724642",
    "coutry_id": 6
  },
  {
    "name": "Latam",
    "phone": "+18664359526",
    "coutry_id": 6
  },
  {
    "name": "Lufthansa",
    "phone": "+18006453880",
    "coutry_id": 6
  },
  {
    "name": "SbAirlines",
    "phone": "+17864371800",
    "coutry_id": 6
  },
  {
    "name": "Tap Portugal",
    "phone": "+18002217370",
    "coutry_id": 6
  },
  {
    "name": "United",
    "phone": "+18002416522",
    "coutry_id": 6
  },
  {
    "name": "Westjet",
    "phone": "+18889378538",
    "coutry_id": 6
  },
  {
    "name": "Aerolíneas Argentinas",
    "phone": "+18003330276",
    "coutry_id": 6
  },
  {
    "name": "AeroMexico",
    "phone": "+18002376639",
    "coutry_id": 6
  },
  {
    "name": "Air Canada",
    "phone": "+18882472262",
    "coutry_id": 6
  },
  {
    "name": "Air France",
    "phone": "+18002372747",
    "coutry_id": 6
  },
  {
    "name": "Alitalia",
    "phone": "+18002235730",
    "coutry_id": 6
  }
]

airlines.each do |airline|
  Airline.create(
    name: airline[:name],
    phone: airline[:phone],
    country_id: airline[:coutry_id]
  )

  puts "Airline #{airline[:name]} has been created"
end

case_causes = [
  {
    name: "Vuelo cancelado"
  },
  {
    name: "Vuelo overbooking"
  },
  {
    name: "Maleta extraviada"
  },
  {
    name: "Vuelo retrasado"
  }
]

case_causes.each do |cause|
  CaseCause.create(name: cause[:name])
end

puts "Case Causes has been created"
