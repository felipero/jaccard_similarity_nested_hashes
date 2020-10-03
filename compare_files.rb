# frozen_string_literal: true

lib_path = File.join(__dir__, 'lib')
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)
require './lib/similarity_scorer'

# Comparator module for similarity between two json files
module Comparator
  module_function

  def compare(file1, file2)
    first = read(file1)
    second = read(file2)
    puts "\nComparing files: #{file1} vs #{file2}:"
    puts "Score: #{SimilarityScorer.score(first, second)}"
  end

  def read(filename)
    File.read(File.join(__dir__, 'data', filename))
  end
end

(1..5).each do |i|
  Comparator.compare('BreweriesMaster.json', "BreweriesSample#{i}.json")
end
