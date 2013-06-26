# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Experience.destroy_all

# Seed an experience
Experience.create tagline: "Check out a mural in the mission district", image: "http://localhost:3000/images/mural.png"
Experience.create tagline: "Visit the parrots on telegraph hill", image: "http://localhost:3000/images/parrots.png"
