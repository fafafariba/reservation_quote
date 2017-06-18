# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



mtl_unit = Unit.where(ad_name: "Montreal Beauty").first_or_create(ad_name: "Montreal Beauty", tax_percent: 0.20, country: "Canada", state: "Quebec", city: "Montreal", lat: 45.5017, lng: 73.5673)
sfo_unit = Unit.where(ad_name: "San Francisco Special").first_or_create(ad_name: "San Francisco Special", tax_percent: 0.19, country: "United States", state: "California", city: "San Francisco", lat: 37.7749, lng: 122.4194)



Date.current.upto(10.days.from_now.to_date) do |date|
  DayPrice.create(unit_id: mtl_unit.id, date: date, price: (100 + 20*rand).round(2), tax_percent: mtl_unit.tax_percent)
  DayPrice.create(unit_id: sfo_unit.id, date: date, price: (200 + 20*rand).round(2), tax_percent: sfo_unit.tax_percent)
end
