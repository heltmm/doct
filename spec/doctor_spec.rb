require 'rspec'
require 'doctor'
require 'pry'
require 'pg'
require 'spec_helper'

  DB = PG.connect({dbname: 'doctors_office_test'})

  describe ('Doctor') do
    describe ('.all') do
      it ('start off with no doctors') do
        expect(Doctor.all).to(eq([]))
      end
    end

  describe("#name") do
   it("tells you their name") do
     doctor = Doctor.new({name:"Dr. Jones", specialty: "Witch Doctor", id: nil})
     expect(doctor.name).to(eq("Dr. Jones"))
     end
   end

   describe("#specialty") do
    it("tells you their specialty") do
      doctor = Doctor.new({name:"Dr. Jones", specialty: "Witch Doctor", id: nil})
      expect(doctor.specialty).to(eq("Witch Doctor"))
      end
    end

  describe("#id") do
    it("sets their ID when you save it") do
      doctor = Doctor.new({name:"Dr. Jones", specialty: "Witch Doctor", id: nil})
      doctor.save()
      expect(doctor.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
  it("lets you save doctors to the database") do
    doctor = Doctor.new({name:"Dr. Jones", specialty: "Witch Doctor", id: nil})
    doctor.save()
    expect(Doctor.all).to(eq([doctor]))
    end
  end

  describe("#==") do
    it("is the same doctor if it they have the same name") do
     doctor1 = Doctor.new({name:"Dr. Jones", specialty: "Witch Doctor", id: nil})
     doctor2 = Doctor.new({name:"Dr. Jones", specialty: "Witch Doctor", id: nil})
     expect(doctor1).to(eq(doctor2))
    end
  end

  describe("#patients") do
    it("returns an array of patients for that doctor") do
      test_doctor = Doctor.new({name:"Dr. Jones", specialty: "Witch Doctor", id: nil})
      test_doctor.save()
      test_task = Patient.new({name:"Mr. Smith", birthday: "1960-05-18", doctor_id: test_doctor.id, id: nil})
      test_task.save()
      test_task2 = Patient.new({name:"Mr. Smith", birthday: "1960-05-18", doctor_id: test_doctor.id, id: nil})
      test_task2.save()
      expect(test_doctor.patients()).to(eq([test_task, test_task2]))
    end
  end

  describe(".find") do
    it("returns a doctor by its ID") do
      test_doctor = Doctor.new({name:"Dr. Jones", specialty: "Witch Doctor", id: nil})
      test_doctor.save()
      test_doctor2 = Doctor.new({name:"Dr. Jones", specialty: "Witch Doctor", id: nil})
      test_doctor2.save()
      expect(Doctor.find(test_doctor2.id())).to(eq(test_doctor2))
    end
  end
end
