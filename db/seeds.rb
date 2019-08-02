# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#create roles
[:super_admin, :admin, :asesor].each do |role_name|
  Role.create(name: role_name)

  puts "Role #{role_name} has been created"
end
