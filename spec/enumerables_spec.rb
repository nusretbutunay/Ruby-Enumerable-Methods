require './app'
describe Enumerable do
  describe "#my_select" do
    let(:block) { proc { |num| num < 8 } }
    let(:arr) {[3, 2, 4, 5, 7, 9, 12, 43, 23]}
    it 'iterates through the array and returns the satisfying items in the array' do
      expect(arr.my_select(&block)).to eql([3,2,4,5,7])
    end
  end
end