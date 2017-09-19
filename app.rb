require 'sinatra'
require 'pry'
require 'sinatra/reloader'
also_reload '.lib/**/*.rb'
require './lib/patient'
require './lib/doctor'
require './lib/specialty'
require 'pg'

DB = PG.connect({dbname: 'doctors_office'})

get('/') do
  erb(:home)
end

get('/admin_home') do
  @doctors = Doctor.all
  erb(:admin_home)
end

get("/doctors/:id") do
  @doctors = Doctor.all
  @doctor = Doctor.find(params.fetch("id").to_i())
  erb(:doctor)
end

get ('/specialty') do
  @specialty = Specialty.all[0]
  @specialties = Specialty.all

  erb(:patient)
end

post("/specialty") do
  name = params['specialty']
  @specialties = Specialty.all
  @specialty = Specialty.find(name)
  erb(:patient)
end

post("/doctors/:id") do
  name = params['name']
  birthday = params['birthday']
  doctor_id = params[:id]

  patient = Patient.new({name: name, birthday: birthday, doctor_id: doctor_id, id: nil})
  patient.save

  @doctors = Doctor.all
  @doctor = Doctor.find(params.fetch("id").to_i())
  erb(:doctor)
end

post('/doctor') do
  name = params['name']
  specialty_name = params['specialty']


  specialty = Specialty.new({name: specialty_name, id: nil})
  specialty.save
  doctor = Doctor.new({name: name, id: nil, specialty_id: specialty.id})
  doctor.save
  @doctors = Doctor.all
  erb(:admin_home)
end
