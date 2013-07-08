# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Experience.destroy_all

# Seed an experience
Experience.create tagline: "Check out a mural in the mission district",
                  image: "mural.png",
                  latitude: 37.768476,
                  longitude: -122.415388


Experience.create tagline: "Visit the parrots on telegraph hill",
                  image: "parrots.png",
                  latitude: 37.802223,
                  longitude: -122.405659

Experience.create tagline: "Visit the birds near shoreline lake",
                  image: "birds.png",
                  latitude: 37.431774,
                  longitude: -122.086706

Experience.create tagline: "Little dolls in East West Bookshop",
                  image: "book_store.jpg",
                  latitude: 37.392493,
                  longitude: -122.080039

Experience.create tagline: "Nice sun set off bridge 84",
                  image: "bridge.jpg",
                  latitude: 37.512449,
                  longitude: -122.118927

Experience.create tagline: "Hang out and have fun in the Castro street, Mountain View",
                  image: "castro_st.jpg",
                  latitude: 37.394164,
                  longitude: -122.079055

Experience.create tagline: "The biggest 'like' sign",
                  image: "facebook.png",
                  latitude: 37.481738,
                  longitude: -122.150076

Experience.create tagline: "Check out the fish in Seascapes Fish & Pets",
                  image: "fish.jpg",
                  latitude: 37.394982,
                  longitude: -122.07992

Experience.create tagline: "Come to see the flowers",
                  image: "flowers.png",
                  latitude: 37.400915,
                  longitude: -122.094887

Experience.create tagline: "Visit the Rengstorff House",
                  image: "rengstoff_house.png",
                  latitude: 37.432102,
                  longitude: -122.087166