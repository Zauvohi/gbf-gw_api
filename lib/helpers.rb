require_relative './repositories/ranking_repository'
require_relative './repositories/cutoffs_repository'
require_relative './repositories/edition_repository'

helpers do
  def ranking_repo(container)
    RankingRepository.new(container)
  end

  def cutoffs_repo(container)
    CutoffsRepository.new(container)
  end

  def edition_repo(container)
    EditionRepository.new(container)
  end

  def halt_if_not_found(obj)
    if obj.respond_to?(:empty?)
      not_found = obj.empty?
    else
      not_found = obj.nil?
    end
    halt(404, { message: 'Not found' }.to_json) if not_found
  end
end
