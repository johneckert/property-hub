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


custom1 = CustomField.create( label: "Number of Bathrooms", internal_name: "number_of_bathrooms", client: c1, field_type: :number)
custom2 = CustomField.create( label: "Wall Color", internal_name: "wall_color", client: c1, field_type: :freeform)
custom3 = CustomField.create( label: "Pet Friendly", internal_name: "pet_friendly", client: c1, field_type: :enumerator, choices: ['Yes', 'No'])

custom4 = CustomField.create( label: "Has Pool", internal_name: "has_pool", client: c2 , field_type: :enumerator, choices: ['Yes', 'No'])
custom5 = CustomField.create( label: "historic", internal_name: "historic", client: c2, field_type: :enumerator, choices: ['Yes', 'No'])

custom6 = CustomField.create( label: "haunted", internal_name: "haunted", client: c3, field_type: :enumerator, choices: ['Yes', 'No'])

custom7 = CustomField.create( label: "Number of Bedrooms", internal_name: "number_of_bedrooms", client: c4, field_type: :number)
custom8 = CustomField.create( label: "Good Deal!!", internal_name: "good_deal", client: c4, field_type: :enumerator, choices: ['Yes', 'No'])
custom9 = CustomField.create( label: "Pet Friendly", internal_name: "pet_friendly", client: c4, field_type: :enumerator, choices: ['Yes', 'No'])

custom10 = CustomField.create( label: "square feet", internal_name: "square_feet", client: c5, field_type: :number)
custom11 = CustomField.create( label: "notes", internal_name: "notes", client: c5, field_type: :freeform)


# Buildings
10.times do
  Building.create(
    street_address: Faker::Address.street_address, 
    city: Faker::Address.city, 
    state: Faker::Address.state_abbr, 
    zip: Faker::Address.zip_code, 
    client: c1, 
    custom_fields: {
      custom1[:internal_name] => Faker::Number.decimal(l_digits: 1, r_digits: 1), 
      custom2[:internal_name] => Faker::Color.color_name,
      custom3[:internal_name] => custom3[:choices].sample
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
      custom4[:internal_name] => custom4[:choices].sample, 
      custom5[:internal_name] => custom5[:choices].sample
    }
  )
end

10.times do
  Building.create(
    street_address: Faker::Address.street_address, 
    city: Faker::Address.city, 
    state: Faker::Address.state_abbr, 
    zip: Faker::Address.zip_code, 
    client: c3,
    custom_fields: {
      custom6[:internal_name] => custom6[:choices].sample, 
    }
  )
end

10.times do
  Building.create(
    street_address: Faker::Address.street_address, 
    city: Faker::Address.city, 
    state: Faker::Address.state_abbr, 
    zip: Faker::Address.zip_code, 
    client: c4,
    custom_fields: {
      custom7[:internal_name] => Faker::Number.number(digits: 1),
      custom8[:internal_name] => custom8[:choices].sample, 
      custom9[:internal_name] => custom9[:choices].sample 
    }
  )
end

10.times do
  Building.create(
    street_address: Faker::Address.street_address, 
    city: Faker::Address.city, 
    state: Faker::Address.state_abbr, 
    zip: Faker::Address.zip_code, 
    client: c5,
    custom_fields: {
      custom10[:internal_name] => Faker::Number.number(digits: 4),
      custom11[:internal_name] => Faker::Lorem.sentence
    }
  )
end