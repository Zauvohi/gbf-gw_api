require 'rom-repository'

class EditionRepository < ROM::Repository[:editions]
  def lastest(limit)
    editions.limit(limit).to_a
  end

  def all
    editions.to_a
  end

  def by_number(number)
    editions.where(number: number).one
  end
end
