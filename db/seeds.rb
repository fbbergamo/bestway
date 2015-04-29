# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
# A B 10
#
# B D 15
#
# A C 20
#
# C D 30
#
# B E 50
#
# D E 30
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
map = "SP"
locations = []
rele = "PATH"
[{ name: "A" }, { name: "B" }, { name: "C" }, { name: "D" }, { name: "E" }].each do |h|
  locations << Location.create(h.merge(map: map))
end

locations[0].create_rel(rele, locations[1], :weight=> 10)
locations[1].create_rel(rele, locations[3], :weight=> 15)
locations[0].create_rel(rele, locations[2], :weight=> 20)
locations[2].create_rel(rele, locations[3], :weight=> 30)
locations[1].create_rel(rele, locations[4], :weight=> 50)
locations[3].create_rel(rele, locations[4], :weight=> 30)
