require './app'

describe Enumerable do
  let(:array) { [1, 2, 3] }
  let(:block) { proc { |x| x * 2 } }
  let(:block_with_index) { proc { |num, i| puts "Num: #{num}, index: #{i}" } }
  let(:range) { (1..5) }
  let(:my_hash) { { first_name: 'somoye', second_name: 'nusret' } }
  let(:hash_block) { proc { |key, value| puts "#{key} is #{value}" } }
  let(:rg) { '/d/' }

  describe '#my_each' do
    it 'it iterates the array and return Enumerator if no block is given' do
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
    it 'it iterates the array and return Enumerator if no block is given' do
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

  describe '#my_select' do
    it 'it iterates the array and return Enumerator if no block is given' do
      expect(array.my_select).to be_a(Enumerator)
    end

    it 'iterates through the array and returns the satisfying items in the array' do
      expect(array.my_select(&block)).to eql(array.select(&block))
    end

    it 'Iterates through the range and executes block' do
      expect(range.my_select(&block)).to eq(range.select(&block))
    end
  end

  describe '#my_all?' do
    it 'return true if none of the array items are false or nil when no block or argument given' do
      expect(array.my_all?).to eq(array.all?)
    end

    it 'return true if none of the array items are false or nil when no block or argument given' do
      expect(array.my_all?(Numeric)).to eq(array.all?(Numeric))
    end

    it 'return true if none of the array items are false or nil when no block or argument given' do
      expect(array.my_all?(rg)).to eq(array.all?(rg))
    end

    it 'return true if none of the array items are false or nil when no block or argument given' do
      expect(array.my_all?(3)).to eq(array.all?(3))
    end

    it 'return true if none of the array items are false or nil when no block or argument given' do
      expect(range.my_all?).to eq(range.all?)
    end

    it 'return true if none of the array items are false or nil when no block or argument given' do
      expect(range.my_all?(Numeric)).to eq(range.all?(Numeric))
    end

    it 'return true if none of the array items are false or nil when no block or argument given' do
      expect(range.my_all?(rg)).to eq(range.all?(rg))
    end

    it 'return true if none of the array items are false or nil when no block or argument given' do
      expect(range.my_all?(3)).to eq(range.all?(3))
    end
  end
end