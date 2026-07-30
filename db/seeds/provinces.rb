Province.create!([
  { name: "Alberta", code: "AB", gst_rate: 5, pst_rate: 0, hst_rate: 0 },
  { name: "British Columbia", code: "BC", gst_rate: 5, pst_rate: 7, hst_rate: 0 },
  { name: "Manitoba", code: "MB", gst_rate: 5, pst_rate: 7, hst_rate: 0 },
  { name: "New Brunswick", code: "NB", gst_rate: 0, pst_rate: 0, hst_rate: 15 },
  { name: "Newfoundland and Labrador", code: "NL", gst_rate: 0, pst_rate: 0, hst_rate: 15 },
  { name: "Northwest Territories", code: "NT", gst_rate: 5, pst_rate: 0, hst_rate: 0 },
  { name: "Nova Scotia", code: "NS", gst_rate: 0, pst_rate: 0, hst_rate: 15 },
  { name: "Nunavut", code: "NU", gst_rate: 5, pst_rate: 0, hst_rate: 0 },
  { name: "Ontario", code: "ON", gst_rate: 0, pst_rate: 0, hst_rate: 13 },
  { name: "Prince Edward Island", code: "PE", gst_rate: 0, pst_rate: 0, hst_rate: 15 },
  { name: "Quebec", code: "QC", gst_rate: 5, pst_rate: 9.975, hst_rate: 0 },
  { name: "Saskatchewan", code: "SK", gst_rate: 5, pst_rate: 6, hst_rate: 0 },
  { name: "Yukon", code: "YT", gst_rate: 5, pst_rate: 0, hst_rate: 0 }
])

puts "✓ Provinces created"