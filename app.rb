module Enumerable
  def my_each
    return enum_for unless block_given?

    i = 0
    new_array = self
    new_array = to_a if is_a?(Hash)
    if is_a?(Range)
      each do |n|
        yield n
      end
      return self
    else
      while i < new_array.length
        yield new_array[i]
        i += 1
      end
    end

    new_array
  end

  def my_each_with_index
    return enum_for unless block_given?

    i = 0
    new_array = self
    new_array = to_a if is_a?(Hash)
    if is_a?(Range)
      j = first
      step(j).each do |n|
        yield n, j
        j += 1
      end
      return self
    else
      while i < new_array.length
        yield new_array[i], i
        i += 1
      end
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
    each do |j|
      if block_given?
        return false unless yield j
      end
      if !block_given? && arg.nil?
        return false if j == false || j.nil?
      end
      unless arg.nil?
        if arg.is_a?(Class)
          return false unless j.is_a?(arg)
        elsif arg.class == Regexp
          return false unless arg.match(j)
        else
          return false unless arg == j
        end
      end
    end
    true
  end

  def my_any?(arg = nil)
    each do |j|
      if block_given?
        return true if yield j
      end
      if arg.nil? && !block_given?
        return true if j
      end
      unless arg.nil?
        if arg.is_a?(Class)
          return true if j.is_a?(arg)
        elsif arg.class == Regexp
          return true if arg.match(j)
        else
          return true unless arg != j
        end
      end
    end
    false
  end

  def my_none?(arg = nil)
    each do |j|
      if block_given?
        return false if yield j
      end
      if arg.nil? && !block_given?
        return false if j
      end
      if arg.class == Regexp
        return false if arg.match(j)
      end
      unless arg.nil? && !arg.is_a?(Class)
        return false if arg == j
      end
      if arg.is_a? Class
        return false if j.is_a?(arg)
      end
    end
    true
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
    long_word = ''
    i = 0
    temp = new_array[0]
    while i < new_array.length - 1
      long_word = yield temp, new_array[i + 1] if new_array[i].is_a?(String)
      i += 1
    end
    return long_word if long_word != ''

    if !block_given?
      if arg[0].class == Symbol
        new_array.my_each { |j| product = product.send(arg[0], j) }
        if product.zero?
          product = 1
          new_array.my_each { |j| product = product.send(arg[0], j) }
        end
      elsif arg[0].class != Symbol && !arg[1].nil?
        new_array.my_each { |j| product = product.send(arg[1], j) }
        if product.zero?
          product = 1
          new_array.my_each { |j| product = product.send(arg[1], j) }
        end
        product = product.send(arg[1], arg[0])
      end
    else
      new_array.my_each { |j| product = yield product, j }
      if product.zero?
        product = 1
        new_array.my_each { |j| product = yield product, j }
      end
      product = yield product, arg[0] unless arg[0].nil?
    end
    raise LocalJumpError if !block_given? && arg.empty?

    product
  end
end

def multiply_els(arr)
  arr.my_inject { |product, n| product * n }
end
