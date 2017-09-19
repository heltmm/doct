class Patient
  attr_reader(:name, :birthday, :doctor_id, :id)

  def initialize(patient)
    @name = patient.fetch(:name)
    @birthday = patient.fetch(:birthday)
    @id = patient.fetch(:id)
    @doctor_id = patient.fetch(:doctor_id)
  end

  def self.all
    returned_patients = DB.exec("SELECT * FROM patients;")
    patients = []
    returned_patients.each do |patient|
      name = patient.fetch("name")
      birthday = patient.fetch("birthday")
      doctor_id = patient.fetch("doctor_id").to_i
      id = patient.fetch("id").to_i
      patients.push(Patient.new({name: name, birthday: birthday, doctor_id: doctor_id, id: id}))
    end
    patients
  end

  def save
    result = DB.exec("INSERT INTO patients (name, birthday, doctor_id) VALUES ('#{@name}', '#{@birthday}', '#{@doctor_id}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_patient)
    self.name.==(another_patient.name).&(self.birthday.==(another_patient.birthday)).&(self.id.==(another_patient.id)).&(self.doctor_id.==(another_patient.doctor_id))
  end
end
