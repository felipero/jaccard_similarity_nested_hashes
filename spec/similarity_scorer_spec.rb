# frozen_string_literal: true

require 'similarity_scorer'

RSpec.describe SimilarityScorer do
  subject(:scorer) { described_class }

  describe '#score' do
    context 'with regular hashes' do
      let(:a) { { foo: 123, bar: 456 } }
      let(:b) { { foo: 123, bar: 456 } }
      let(:c) { { 123 => :foo, 456 => :bar } }
      let(:d) { { foo: 123, bar: 789 } }
      let(:e) { { foo: 123, baz: 789, bar: 456, fuu: 123 } }

      it 'is 1 for identical hashes' do
        expect(scorer.score(a, b)).to eq 1.0
      end

      it 'is 0 for completely different hashes' do
        expect(scorer.score(a, c)).to eq 0.0
      end

      it { expect(scorer.score(a, d)).to eq 1.fdiv(3) }

      it 'is 0.5 for half matching hashes' do
        expect(scorer.score(a, e)).to eq 0.5
      end
    end

    context 'when hashes have nested lists of hashes' do
      let(:felipe) do
        {
          name: 'Felipe',
          age: 38,
          skills: [
            { name: 'Java', exp: 'strong' },
            { name: 'Ruby', exp: 'strong' },
            { name: 'Elixir', exp: 'superb' }
          ]
        }
      end
      let(:gabi) do
        {
          name: 'Gabriela',
          age: 38,
          skills: [
            { name: 'Java', exp: 'strong' },
            { name: 'Ruby', exp: 'regular' },
            { name: 'Scala', exp: 'superb' }
          ]
        }
      end

      it { expect(scorer.score(felipe, gabi)).to eq 1.fdiv(3) }
    end

    context 'with string parameters' do
      let(:a) { { foo: 123, bar: 456 } }
      let(:b) { '{ "foo": 123, "bar": 456 }' }
      let(:e) { '{ "foo": 123, "baz": 789, "bar": 456, "fuu": 123 }' }

      it { expect(scorer.score(b, e)).to eq 0.5 }
    end
  end
end
