module Enumerable
  def my_each
    return enum_for unless block_given?

    i = 0
    new_array = self
    new_array = to_a if is_a?(Range) || is_a?(Hash)
    while i < new_array.length
      yield new_array[i]
      i += 1
    end
    new_array
  end

  def my_each_with_index
    return enum_for unless block_given?

    i = 0
    new_array = self
    new_array = to_a if is_a?(Range) || is_a?(Hash)
    while i < new_array.length
      yield new_array[i], i
      i += 1
    end
    new_array
  end

  def my_select
    return enum_for unless block_given?

    new_numbers = []
    my_each { |i| new_numbers.push(i) if yield(i) }
    new_numbers
  end

  def my_all?(arg = nil)
    return false if arg.nil? && !block_given? && !my_each { |j| j }

    unless arg.nil?
      return false unless my_each { |j| j.class == arg || arg.match(j) }
    end
    return false if block_given? && !my_each { |j| yield(j) }

    true
  end

  def my_any?(arg = nil)
    return true unless arg.nil? || !my_each { |j| j.class == arg }
    return true unless block_given? || !my_each { |j| j }
    return true if block_given? && my_each { |j| yield(j) }

    true
  end

  def my_none?(arg = nil)
    !my_any?(arg)
  end

  def my_count(counted = nil)
    new_array = is_a?(Range) ? to_a : self
    return new_array.length if counted.nil? && !block_given?

    counting = 0
    if block_given?
      new_array.my_each { |j| counting += 1 if yield j }
    end
    unless counted.nil?
      new_array.my_each { |j| counting += 1 if j == counted }
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
    if !block_given?
      if arg[0].class == Symbol
        new_array.my_each { |i| product = product.send(arg[0], i) }
        if product.zero?
          product = 1
          new_array.my_each { |i| product = product.send(arg[0], i) }
        end
      elsif arg[0].class != Symbol && !arg[1].nil?
        new_array.my_each { |i| product = product.send(arg[1], i) }
        if product.zero?
          product = 1
          new_array.my_each { |i| product = product.send(arg[1], i) }
        end
        product = product.send(arg[1], arg[0])
      end
    else
      new_array.my_each { |i| product = yield product, i }
      if product.zero?
        product = 1
        new_array.my_each { |i| product = yield product, i }
      end
      product = yield product, arg[0] unless arg[0].nil?
    end
    product
  end
end

def multiply_els(arr)
  arr.my_inject { |product, n| product * n }
end
