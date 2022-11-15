class Patient
    attr_reader :name, :blood_type
    # ATTR_ACCESSOR so the Repo can GET and SET the ID
    attr_accessor :room, :id
    # State
    def initialize(attrs={})
      @id = attrs[:id]
      @name = attrs[:name]
      @blood_type = attrs[:blood_type] || 'Unknown'
      @cured = attrs[:cured] || false
      @room = attrs[:room]
    end
    # Behavior
    def cure
      @cured = true
    end
  end