Customer.create!(
  email: "admin@prairieseedco.ca",
  password: "password123",
  password_confirmation: "password123",

  first_name: "Admin",
  last_name: "User",
  phone_number: "2045551234",

  street_address: "160 Princess Street",
  city: "Winnipeg",
  province: Province.find_by!(code: "MB"),
  postal_code: "R3B 1K9",
  country: "Canada",

  admin: true
)

puts "✓ Admin account created"