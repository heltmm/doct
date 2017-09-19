require 'rspec'
require 'specialty'
require 'doctor'
require 'pry'
require 'pg'
require 'spec_helper'

  DB = PG.connect({dbname: 'doctors_office_test'})

  describe ('Specialty') do
    describe ('.all') do
      it ('start off with no specialties') do
        expect(Specialty.all).to(eq([]))
      end
    end

  describe("#name") do
   it("tells you their name") do
     specialty = Specialty.new({name:"Orthapedist", id: nil})
     expect(specialty.name).to(eq("Orthapedist"))
     end
   end

  describe("#id") do
    it("sets their ID when you save it") do
      specialty = Specialty.new({name:"Orthapedist", id: nil})
      specialty.save()
      expect(specialty.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
  it("lets you save specialties to the database") do
    specialty = Specialty.new({name:"Orthapedist", id: nil})
    specialty.save()
    expect(Specialty.all).to(eq([specialty]))
    end
  end

  describe("#==") do
    it("is the same specialty if it they have the same name") do
     specialty1 = Specialty.new({name:"Orthapedist", id: nil})
     specialty2 = Specialty.new({name:"Orthapedist", id: nil})
     expect(specialty1).to(eq(specialty2))
    end
  end

  describe("#doctors") do
    it("returns an array of patients for that specialty") do
      test_specialty = Specialty.new({name:"Orthapedist", id: nil})
      test_specialty.save()
      test_task = Doctor.new({name:"Dr. Smith", specialty_id: test_specialty.id, id: nil})
      test_task.save()
      test_task2 = Doctor.new({name:"Dr. Smith", specialty_id: test_specialty.id, id: nil})
      test_task2.save()
      expect(test_specialty.doctors()).to(eq([test_task, test_task2]))
    end
  end

  describe(".find") do
    it("returns a specialty by its name") do
      test_specialty = Specialty.new({name:"Dr. Jones", id: nil})
      test_specialty.save()
      test_specialty2 = Specialty.new({name:"Dr. Jones", id: nil})
      test_specialty2.save()
      expect(Specialty.find(test_specialty2.name())).to(eq(test_specialty2))
    end
  end
end
