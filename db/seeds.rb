# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

projects = Project.create([
  {
    name: "Gigster clone",
    budget: "5k-10k",
    start: "1 week",
    project_type: "Website, Backend, UI/UX, Android, iOS",
    owner_name: "Ismail",
    phone: "+212600828689",
    email: "ismail@unik.ma"
    },
  {
    name: "FB clone",
    budget: "10k-20k",
    start: "1 month",
    project_type: "Backend, Android, iOS",
    owner_name: "Mohamed",
    phone: "+467289430221",
    email: "ismail@werunik.com"
    }
])
