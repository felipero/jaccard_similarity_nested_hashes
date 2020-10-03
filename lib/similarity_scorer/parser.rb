# frozen_string_literal: true

require 'oj'

module SimilarityScorer
  # Module with functions to parse json strings into namespaced hashes
  module Parser
    module_function

    def parse(json)
      return {} if json.nil? || json.strip.empty?

      Oj.load(json)
    end

    def namespaced(entry, namespace_arr = [], acc = {})
      return acc.update({ namespace_arr => entry }) unless entry.is_a?(Hash) || entry.is_a?(Array)

      processor = lambda { |obj|
        obj.each { |key, val| namespaced(val, namespace_arr + [key], acc) }
      }

      if entry.is_a? Array
        entry.each do |nested_entry|
          processor.call(nested_entry)
        end
      else
        processor.call(entry)
      end

      acc
    end
  end
end
