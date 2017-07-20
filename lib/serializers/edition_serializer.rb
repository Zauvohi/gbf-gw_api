class EditionSerializer
  def initialize(data)
    @data = data
  end

  def to_h
    @data.to_h
  end

  def as_json
    self.to_h.to_json
  end
end
