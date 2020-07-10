module Enumerable
  def my_each
    return enum_for unless block_given?

    i = 0
    new_array = is_a?(Range) ? to_a : self
    new_array = is_a?(Hash) ? to_a : self
    while i < new_array.length
      yield new_array[i]
      i += 1
    end
    new_array
  end

  def my_each_with_index
    return enum_for unless block_given?

    i = 0
    # new_array = self.is_a?(Range) ? self.to_a : self
    new_array = is_a?(Hash) ? to_a : self
    while i < new_array.length
      yield new_array[i], i
      i += 1
    end
    new_array
  end

  def my_select
    return enum_for unless block_given?

    new_numbers = []
    each do |i|
      new_numbers.push(i) if yield(i)
    end
    new_numbers
  end

  def my_all?(arg)
    condition = true
    unless arg.nil?
      each do |j|
        condition = false unless j.class == arg || arg.match(j)
      end
    end
    unless block_given?
      each do |j|
        condition = false unless j
      end
    end
    if block_given?
      each do |j|
        condition = false unless yield(j)
      end
    end
    condition
  end

  def my_any?(arg = nil)
    condition = false
    unless arg.nil?
      each do |j|
        condition = true if j.class == arg # || arg.match(j)
      end
    end
    unless block_given?
      each do |j|
        condition = true if j
      end
    end
    if block_given?
      each do |j|
        condition = true if yield(j)
      end
    end
    condition
  end

  def my_none?(arg = nil)
    !my_any?(arg)
  end

  def my_count(counted = nil)
    j = 0
    new_array = is_a?(Range) ? to_a : self
    return new_array.length if counted.nil? && !block_given?

    counting = 0
    if block_given?
      while j < new_array.length
        counting += 1 if yield new_array[j]
        j += 1
      end
  end
    unless counted.nil?
      while j < new_array.length
        counting += 1 if new_array[j] == counted
        j += 1
      end
    end
    counting
  end

  def my_map(proc = nil)
    return enum_for unless block_given?

    arr = []
    each do |i|
      if !proc.nil?
        arr.push(proc.call(i))
      else
        arr.push(yield i)
      end
    end
    arr
  end

  def my_inject(*arg)
    new_array = is_a?(Range) ? to_a : self
    product = 0
    i = 0
    if !block_given?
      if arg[0].class == Symbol
        while i < new_array.length
          product = product.send(arg[0], new_array[i])
          if product.zero?
            product = 1
            product = product.send(arg[0], new_array[i])
          end
          i += 1
        end
      elsif arg[0].class != Symbol && !arg[1].nil?
        while i < new_array.length
          product = product.send(arg[1], new_array[i])
          i += 1
          product = 1 if product.zero?
        end
        product = product.send(arg[1], arg[0])
      end
    else
      while i < new_array.length
        product = yield product, new_array[i]
        if product.zero?
          product = 1
          product = yield product, new_array[i]
        end
        i += 1
      end
      product = yield product, arg unless arg.nil?
    end
    product
  end
end

def multiply_els(arr)
  arr.my_inject { |product, n| product * n }
end

# p [1, 2, 3].my_select
# p [1, true, 'hi', []].my_all?
# p [1.0, 2.0, 3.0].my_all?(Float)
# p ['dog','door','dish'].my_all?(/d/)
# p [1, 'dog' , 1].my_any?
# p ['a', 'b', 3].my_none?(Integer)
# p ['b', 2i, 'a'].my_none?(Numeric)
# p ['dog','door','dish'].my_none?(/s/)
# p ['dog','door','dish'].my_none?(/dog/)
# p [1, 2, 3].my_count(3)
# p (1..5).my_count
# p [1, 2, 3, 4, 5].my_count {|num| num > 3}
# p [1, 2, 3].count{ |num| num + 1 }
# p [1, 2, 3].my_map
# p (1..5).my_inject { |prod, n| prod * n }
# p (1..5).my_inject(2) { |prod, n| prod * n }
# p [1, 2, 3].my_inject(:+)
# p (1..5).my_inject(3, :+)
