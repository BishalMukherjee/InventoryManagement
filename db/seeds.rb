# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create([
  {provider: "google_oauth2",
  name: "Bishal Mukherjee",
  email: "bishalmukherjee7@gmail.com",
  category_access: true,
  brand_access: true,
  item_access: true,
  employee_access: true,
  storage_access: true,
  admin_access: true,
  id: "1"}])

Category.create([{
  name: "Keyboard"
},
{
  name: "Monitor"
}])

Brand.create([{
  name: "HP",
  category_id: "1"
},
{
  name:"Dell",
  category_id: "2"
}])

Storage.create([{
  category_id: "1",
  total: 10,
  buffer: 1,
  procurement_time: Date.parse("2020-11-25")
}])

Employee.create([{
  name: "Abhishek Ghosh",
  email: "abhi@gmail.com",
  status: true
}])

Item.create([{
  name: "HP-637",
  brand_id: "1",
  status: true,
}])

Issue.create([{
  item_id: "1",
  details: "Not working properly. Need to be fixed.",
  status: false
}])