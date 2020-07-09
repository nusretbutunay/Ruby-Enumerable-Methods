module Enumerable
  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i+=1
    end
  end
end


numbers = [4,1,3,2,6,7]
numbers.my_each {|number| puts "current number is #{number}"}
