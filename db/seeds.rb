# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

c1 = Client.create(name: Faker::Company.name)
c2 = Client.create(name: Faker::Company.name)
c3 = Client.create(name: Faker::Company.name)
c4 = Client.create(name: Faker::Company.name)
c5 = Client.create(name: Faker::Company.name)

custom1= CustomField.create( label: "Number of Bathrooms", internal_name: "number_of_bathrooms", client: c1, field_type: :number)
custom2= CustomField.create( label: "Wall Color", internal_name: "wall-color", client: c1, field_type: :freeform)
custom3= CustomField.create( label: "Pet Friendly", internal_name: "pet_friendly", client: c1, field_type: :enumerator, choices: ['Yes', 'No'])
custom4= CustomField.create( label: "Has Pool", internal_name: "hasPool?", client: c2 , field_type: :enumerator, choices: ['Yes', 'No'])
custom5= CustomField.create( label: "historic", internal_name: "historic", client: c2, field_type: :enumerator, choices: ['Yes', 'No'])
custom6= CustomField.create( label: "haunted", internal_name: "haunted", client: c3, field_type: :enumerator, choices: ['Yes', 'No'])
custom7= CustomField.create( label: "Number of Bedrooms", internal_name: "num_bedrooms", client: c4, field_type: :number)
custom8= CustomField.create( label: "Good Deal!!", internal_name: "good_deal", client: c4, field_type: :enumerator, choices: ['Yes', 'No'])
custom9= CustomField.create( label: "Pet Friendly", internal_name: "pet_friendly", client: c4, field_type: :enumerator, choices: ['Yes', 'No'])
custom10= CustomField.create( label: "square feet", internal_name: "square feet", client: c5, field_type: :number)
custom11= CustomField.create( label: "notes", internal_name: "notes", client: c5, field_type: :freeform)


# Buildings
10.times do
  Building.create(
    street_address: Faker::Address.street_address, 
    city: Faker::Address.city, 
    state: Faker::Address.state_abbr, 
    zip: Faker::Address.zip_code, 
    client: c1, 
    custom_fields: {
      "number_of_bathrooms" => Faker::Number.decimal(l_digits: 1, r_digits: 1), 
      "wall_color" => Faker::Color.color_name
    }
  )
end

10.times do
  Building.create(
    street_address: Faker::Address.street_address, 
    city: Faker::Address.city, 
    state: Faker::Address.state_abbr, 
    zip: Faker::Address.zip_code, 
    client: c2, 
    custom_fields: {
      "has_pool" => Faker::Boolean.boolean, 
      "historic" => Faker::Boolean.boolean
    }
  )
end

10.times do
  Building.create(
    street_address: Faker::Address.street_address, 
    city: Faker::Address.city, 
    state: Faker::Address.state_abbr, 
    zip: Faker::Address.zip_code, 
    client: c3
  )
end

10.times do
  Building.create(
    street_address: Faker::Address.street_address, 
    city: Faker::Address.city, 
    state: Faker::Address.state_abbr, 
    zip: Faker::Address.zip_code, 
    client: c4
  )
end

10.times do
  Building.create(
    street_address: Faker::Address.street_address, 
    city: Faker::Address.city, 
    state: Faker::Address.state_abbr, 
    zip: Faker::Address.zip_code, 
    client: c5
  )
end