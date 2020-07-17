require './app'
describe Enumerable do
  describe "#my_select" do
   let(:arr) {[3, 2, 4, 5, 7, 9, 12, 43, 23]}
   it 'iterates through the array and returns the satisfying items in the array' do
    expect { |b| arr.my_select(&b) }.to yield_control
   end
  end
end