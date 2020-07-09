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

  def my_map(proc = nil)
    arr = []
    for i in self
      if (proc != nil)
        arr.push(proc.call(i))
      else
        arr.push(yield i)
      end
    end
    arr
  end

  def my_inject(arg=nil)
    product = 0
    i = 0
    while i < self.length
      product = yield product, self[i]
      if(product == 0)
        product=1
        product = yield product, self[i]
      end
      i+=1
    end
    if arg !=nil
      product = yield product, arg
    end
    product
  end
end

def multiply_els(arr)
  arr.my_inject { |product, n| product * n }
end

numbers = [1,2,3,4,5]
numbers.my_each {|number| puts "current number is #{number}"}
numbers.my_each_with_index {|number, index| puts "The value is #{number} and the index is #{index}"}
p numbers.my_select {|number| number > 2}
p numbers.my_all? {|number| number > 0}
p numbers.my_any? {|number| number > 1}
p numbers.my_none? {|number| number < 2}
p numbers.my_count(6)
my_map_variable = Proc.new { |n| n * 2 }
p numbers.my_map() { |n| n + 2 }
p numbers.my_map(my_map_variable) { |n| n + 2 }
p numbers.my_inject(1) { |product, n| product + n }
p multiply_els([2,4,5])
