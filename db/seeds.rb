# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
units = Unit.create([
  {
  name: "Unidad 1",
  },
  {
  name: "Unidad 2",
  },
])

users = User.create([
  {
  #unit_id: 1,
  name: "WAYLON",
  email: "waylon@madrid.es",
  last_name: "JENNINGS",
  last_name_alt: "OUTLAW",
  },
  {
  #unit_id: 2,
  name: "PACO",
  email: "paco@madrid.es",
  last_name: "PEREZ",
  last_name_alt: "MARCOS",
  },
  {
  #unit_id: 2,
  name: "JOSE",
  email: "jose@madrid.es",
  last_name: "TOSCANO",
  last_name_alt: "MARCOS",
  },
  {
  #unit_id: 2,
  name: "ALVARO",
  email: "alvaro@madrid.es",
  last_name: "MONJE",
  last_name_alt: "TOSCANO",
  },
  {
  #unit_id: 1,
  name: "ALBA",
  email: "alba@madrid.es",
  last_name: "MONJE",
  last_name_alt: "MARCOS",
  },
  {
  #unit_id: 2,
  name: "INES",
  email: "ines@madrid.es",
  last_name: "MONJE",
  last_name_alt: "PEREZ",
  },
  {
  #unit_id: 1,
  name: "KRIS",
  email: "kris@madrid.es",
  last_name: "KRISTOFFERSON",
  last_name_alt: "MCGEE",
  }])
