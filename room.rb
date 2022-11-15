require_relative 'patient'

class Room
  class CapacityReachedError < Exception; end
  attr_reader :id, :capacity
  def initialize(attrs={})
    @id = attrs[:id]
    @capacity = attrs[:capacity]
    @patients = attrs[:patients] || []
  end

  def full?
    @patients.count == @capacity
  end

  def add_patient(patient)
    fail CapacityReachedError, 'The room is full! Choose another room' if full?
    @patients << patient
    patient.room = self
    puts "Patient #{patient.name} was added to the room"
  end

  def list_patients
    @patients.each do |patient|
      puts "#{patient.name} -> #{patient.blood_type}"
    end
  end
end

# room_one = Room.new(capacity: 2)
# # room_two = Room.new(number: 2, capacity: 4)
# patient_one = Patient.new(name: 'Mary', blood_type: '-O')
# patient_two = Patient.new(name: 'Joe', blood_type: '+AB')
# patient_three = Patient.new(name: 'Anna', blood_type: '-B')

# room_one.add_patient(patient_one)
# room_one.add_patient(patient_two)
# room_one.add_patient(patient_three)
