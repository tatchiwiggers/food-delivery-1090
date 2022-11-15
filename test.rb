require_relative 'patient'
require_relative 'room'
require_relative 'patient_repository'
require_relative 'room_repository'

patient_file = './data/patients.csv'
room_file = './data/rooms.csv'

# room_repo = RoomRepository.new(room_file)
# patient_repo = PatientRepository.new(patient_file, room_repo)



# patient_one = Patient.new(name: 'Mary', blood_type: '-O')
# patient_two = Patient.new(name: 'John', blood_type: '-O')
# patient_repo.add_patient(patient_one)
# patient_repo.add_patient(patient_two)
# p patient_one
# p patient_two