require 'sinatra'
require 'pry'
require 'sinatra/reloader'
also_reload '.lib/**/*.rb'
require './lib/patient'
require './lib/doctor'
require 'pg'

DB = PG.connect({dbname: 'doctors_office'})

get('/') do

  erb(:home)
end

post('/patient') do
  name = params['name']
  birthday = params['birthday']
  doctor_id = params['doctor_id']

  patient = Patient.new({name: name, birthday: birthday, doctor_id: doctor_id, id: nil})
  patient.save
  erb(:home)
end

post('/doctor') do
  name = params['name']
  specialty = params['specialty']


  doctor = Doctor.new({name: name, specialty: specialty, id: nil})
  doctor.save
  erb(:home)
end
