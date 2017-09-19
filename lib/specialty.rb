class Specialty
  attr_reader(:name, :id)

  def initialize(specialty)
    @name = specialty.fetch(:name)
    @id = specialty.fetch(:id)
  end

  def self.all
    returned_specialties = DB.exec("SELECT * FROM specialties;")
    specialties = []
    returned_specialties.each do |specialty|
      name = specialty.fetch("name")
      id = specialty.fetch("id").to_i
      specialties.push(Specialty.new({name: name, specialty: specialty, id: id}))
    end
    specialties
  end

  def save
    result = DB.exec("INSERT INTO specialties (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_specialty)
    self.name().==(another_specialty.name).&(self.id().==(another_specialty.id()))
  end

  def doctors
    specialty_doctors = []
    doctors = DB.exec("SELECT * FROM doctors WHERE specialty_id = #{self.id()};")
    doctors.each() do |doctor|
      name = doctor.fetch("name")
      specialty_id = doctor.fetch("specialty_id").to_i
      id = doctor.fetch("id").to_i
      specialty_doctors.push(Doctor.new({name: name, id: id, specialty_id: specialty_id}))
    end
    specialty_doctors
  end

  def self.find(name)
    found_specialty = nil
    Specialty.all().each() do |specialty|
      if specialty.name().==(name)
        found_specialty = specialty
      end
    end
    found_specialty
  end
end
