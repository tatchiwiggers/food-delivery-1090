require 'csv'
require_relative 'patient'

patients = []
csv_file = './data/patients.csv'

CSV.foreach(csv_file, headers: :first_row, header_converters: :symbol) do |row|
    # p row[:id]
    # p row.class
    # p (row[:cured] == 'true').class
    # p row
    row[:id]    = row[:id].to_i          # Convert column to Integer
    row[:cured] = row[:cured] == "true"  # Convert column to boolean
    # p row
    patients << Patient.new(row)
end

p patients

# GO AND ADD ID TO THE PATIENT MODEL and run this code again.

# back to script -> # AUTO-INCREMENT