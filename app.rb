module Enumerable
  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i+=1
    end
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield self[i], i
      i+=1
    end
  end

  def my_select
    new_numbers = []
    for i in self
      if yield(i)
        new_numbers.push(i)
      end
    end
    new_numbers
  end

  def my_all?
    condition = true
    for j in self
      if !yield(j)
        condition = false
      end
    end
    condition
  end

  def my_any?
    for j in self
      if yield(j)
        return true
      end
    end
    false
  end

  def my_none?
    condition = true
    for j in self
      if yield(j)
        condition = false
      end
    end
    condition
  end

  def my_count(counted)
    counting = 0
    for j in self
        if j == counted
        counting+=1
      end
    end
    counting
  end

  def my_map
    arr = []
    for i in self
      arr.push(yield i)
    end
    arr
  end
end

numbers = [4,1,3,2,6,7,1,7,7]
numbers.my_each {|number| puts "current number is #{number}"}
numbers.my_each_with_index {|number, index| puts "The value is #{number} and the index is #{index}"}
p numbers.my_select {|number| number > 2}
p numbers.my_all? {|number| number > 0}
p numbers.my_any? {|number| number > 1}
p numbers.my_none? {|number| number < 2}
p numbers.my_count(7)
p numbers.my_map { |n| n * 2 }