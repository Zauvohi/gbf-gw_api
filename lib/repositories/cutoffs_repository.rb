require 'rom-repository'

class CutoffsRepository < ROM::Repository[:cutoffs]
  def most_recent
    cutoffs.last
  end
end
