require_relative 'room'
require 'csv'
# require 'pry-byebug'

class RoomRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @rooms = []
    load_csv
  end

  def add_room(room)
    @rooms << room
  end

  def find_room(id)
    @rooms.find {|room| room.id == id}
  end


  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i          # Convert column to Integer
      row[:capacity] = row[:capacity].to_i
      @rooms << Room.new(row)
    end
  end
end