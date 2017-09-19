require 'rspec'
require 'patient'
require 'pry'
require 'pg'
require 'spec_helper'

  DB = PG.connect({dbname: 'doctors_office_test'})

  describe ('Patient') do
    describe ('.all') do
      it ('start off with no patients') do
        expect(Patient.all).to(eq([]))
      end
    end

  describe("#name") do
   it("tells you their name") do
     patient = Patient.new({name:"Mr. Smith", birthday: "1960-05-18", doctor_id: 1, id: nil})
     expect(patient.name).to(eq("Mr. Smith"))
     end
   end

   describe("#birthday") do
    it("tells you their birthday") do
      patient = Patient.new({name:"Mr. Smith", birthday: "1960-05-18", doctor_id: 1, id: nil})
      expect(patient.birthday).to(eq("1960-05-18"))
      end
    end

  describe("#id") do
    it("sets their ID when you save it") do
      patient = Patient.new({name:"Mr. Smith", birthday: "1960-05-18", doctor_id: 1, id: nil})
      patient.save()
      expect(patient.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
  it("lets you save patients to the database") do
    patient = Patient.new({name:"Mr. Smith", birthday: "1960-05-18", doctor_id: 1, id: nil})
    patient.save()
    expect(Patient.all).to(eq([patient]))
    end
  end

  describe("#==") do
    it("is the same patient if it they have the same name") do
     patient1 = Patient.new({name:"Mr. Smith", birthday: "1960-05-18", doctor_id: 1, id: nil})
     patient2 = Patient.new({name:"Mr. Smith", birthday: "1960-05-18", doctor_id: 1, id: nil})
     expect(patient1).to(eq(patient2))
    end
  end
end
