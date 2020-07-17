require './app'

describe Enumerable do
  let(:array) { [1, 2, 3] }
  let(:block) { proc { |x| x * 2 } }
  let(:block_with_index) { proc { |num, i| puts "Num: #{num}, index: #{i}"}}
  let(:range) { (1..5) }
  let(:my_hash) { { first_name: 'somoye', second_name: 'nusret' } }
  let(:hash_block) { proc { |key, value| puts "#{key} is #{value}" } }

  describe '#my_each' do
    it 'it iterates the array' do
      expect(array.my_each).to be_a(Enumerator)
    end

    it 'Iterates through the array and executes block' do
      expect(array.my_each(&block)).to eq(array.each(&block))
    end

    it 'Iterates through the range and executes block' do
      expect(range.my_each(&block)).to eq(range.each(&block))
    end

    it 'Iterates through the hash and executes block' do
      expect(my_hash.my_each(&block)).to eq(my_hash.each(&block))
    end

    it 'Iterates through the hash and executes block' do
      expect(my_hash.my_each(&hash_block)).to eq(my_hash.each(&hash_block))
    end
  end

  describe '#my_each_with_index' do
    it 'it iterates the array' do
      expect(array.my_each_with_index).to be_a(Enumerator)
    end

    it 'Iterates through the array and executes block' do
      expect(array.my_each_with_index(&block)).to eq(array.each_with_index(&block))
    end

    it 'Iterates through the array and executes block' do
      expect(array.my_each_with_index(&block_with_index)).to eq(array.each_with_index(&block_with_index))
    end

    it 'Iterates through the range and executes block' do
      expect(range.my_each_with_index(&block)).to eq(range.each_with_index(&block))
    end

    it 'Iterates through the range and executes block' do
      expect(range.my_each_with_index(&block_with_index)).to eq(range.each_with_index(&block_with_index))
    end

    it 'Iterates through the hash and executes block' do
      expect(my_hash.my_each_with_index(&block)).to eq(my_hash.each_with_index(&block))
    end

    it 'Iterates through the hash and executes block' do
      expect(my_hash.my_each_with_index(&hash_block)).to eq(my_hash.each_with_index(&hash_block))
    end
  end

  # describe "#my_select" do

#   let(:block) { proc { |num| num < 8 } }

#   let(:arr) {[3, 2, 4, 5, 7, 9, 12, 43, 23]}

#   it 'iterates through the array and returns the satisfying items in the array' do

#     expect(arr.my_select(&block)).to eql([3,2,4,5,7])

#   end

# end

end

