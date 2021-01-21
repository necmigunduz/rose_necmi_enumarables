require './enumerables.rb'

describe Enumerable do
    let(:arr) { %w[a b c] }
    let(:range) { (1...10) }
    let(:hash) { { a: '1', b: 'a', c: 3 } }
    let(:arr_2) { [5, 1, 2, 5] }
  
    describe '#my_each' do
        it 'should return the same array' do
            expect(arr.my_each { |a| a }).to eq(%w[a b c])
        end

        it 'should return the same range' do
            expect(range.my_each { |a| a }).to eql(1...10)
        end

        it 'should return the same hash' do
            expect(hash.my_each { |a| a }).to eql({ a: '1', b: 'a', c: 3 })
        end

        it 'should return the same array' do
            expect(arr_2.my_each { |a| a }).to eql([5,1,2,5])
        end

        context 'when given no block' do
            it 'should return an enumerator' do
              expect(arr.my_each).to be_an(Enumerator)
            end
          end
    end

end