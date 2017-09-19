require 'sinatra'
require 'pry'
require 'sinatra/reloader'
also_reload '.lib/**/*.rb'
require './lib/patient'
require './lib/doctor'
require 'pg'

DB = PG.connect({dbname: 'doctors_office'})

get('/') do
  @doctors = Doctor.all
  erb(:home)
end

get("/doctors/:id") do
  @doctors = Doctor.all
  @doctor = Doctor.find(params.fetch("id").to_i())
  erb(:doctor)
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
  specialty = params['specialty']

  doctor = Doctor.new({name: name, specialty: specialty, id: nil})
  doctor.save
  @doctors = Doctor.all
  erb(:home)
end
