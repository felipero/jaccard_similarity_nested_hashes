# frozen_string_literal: true

require 'similarity_scorer/parser'

RSpec.describe SimilarityScorer::Parser do
  subject(:parser) { described_class }

  describe '.parse' do
    it { expect(parser.parse('')).to eq({}) }
    it { expect(parser.parse('  ')).to eq({}) }
    it { expect(parser.parse(nil)).to eq({}) }
    it { expect { parser.parse('123/asd') }.to raise_error Oj::ParseError }

    context 'with complex json input' do
      let(:input) { '{":a":123,":b":"123",":c":[1,2,3]}' }

      it { expect(parser.parse(input)).to eq({ a: 123, b: '123', c: [1, 2, 3] }) }
    end
  end

  describe '#namespaced' do
    context 'with nested hashes' do
      let(:input) { { a: { c: 3, d: { e: 4 } }, b: 2 } }
      let(:expected) { { [:b] => 2, %i[a d e] => 4, %i[a c] => 3 } }

      it { expect(parser.namespaced(input)).to eq expected }
    end

    context 'with nested list of hashes' do
      let(:input) { { a: [{ c: 3 }, { d: 5 }], b: 2 } }
      let(:expected) { { [:b] => 2, %i[a d] => 5, %i[a c] => 3 } }

      it { expect(parser.namespaced(input)).to eq expected }
    end
  end
end
