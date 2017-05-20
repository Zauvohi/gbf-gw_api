require 'rom-repository'

class CutoffsRepo < ROM::Repository[:cutoffs]
  def most_recent
    cutoffs.last
  end
end
