require 'csv'
require_relative 'patient'

class PatientRepository
  def initialize(csv_file, room_repository)
    @csv_file = csv_file
    @patients = []
    # PatientRepository has a dependence on Room Repository
    @room_repository = room_repository
    # Initialize the Repository with @next_id = 1 and let Load_csv update it.
    @next_id = 1
    load_csv
  end

  def all
    @patients
  end

  def add_patient(patient)
    # What ID should this patient have?
    patient.id = @next_id
    @patients << patient
    # save_to_csv
    @next_id += 1
  end

  def find(id)
    # Remember to FIND by the ID of the object
    @patients.find {|patient| patient.id == id}
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i # CONVERT STRING TO INTEGER
      row[:cured] = row[:cured] == "true"  # Convert column to boolean
      # USE THE ROOM_REPOSITORY TO FIND THE CORRECT INSTANCE OF ROOM
      row[:room] = @room_repository.find_room(row[:room_id].to_i)
      @patients << Patient.new(row)
    end
    # REMEMBER TO SET THE @NEXT_ID BASED ON THE ID OF THE LAST ELEMENT
    @next_id = @patients.last.id + 1 unless @patients.empty?
  end
end