# frozen_string_literal: true

require 'set'
require 'similarity_scorer/parser'

# SimilarityScorer scores a value between 0 and 1 for two objects,
# using the jaccard similarity algorithm
module SimilarityScorer
  module_function

  def score(first, second)
    return 1.0 if first == second

    first = Parser.parse(first) if first.is_a? String
    second = Parser.parse(second) if second.is_a? String

    fset = Parser.namespaced(first).to_set
    sset = Parser.namespaced(second).to_set
    fset.intersection(sset)
        .size
        .fdiv(
          fset.union(sset).size
        )
  end
end
