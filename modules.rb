module Enumerable
  def my_each
    enum = to_enum(:each)
    return enum unless block_given?

    for i in enum do
      yield i
    end
  end

  def my_each_with_index
    enum = to_enum(:each_with_index)
    return enum unless block_given?

    index = 0
    for i in enum do
      yield i, index
      index += 1
    end
  end

  def my_select
    enum = to_enum
    return enum unless block_given?

    array = []
    enum.my_each { |i| array.push(i) if yield i }
    array
  end

  def my_all?
    enum = to_enum
    if block_given?
      enum.my_each { |i| return false unless yield i }
    else
      enum.my_each { |i| return false unless ->(o) { o }.call(i) }
    end
    true
  end

  def my_any?
    enum = to_enum(:any?)
    if block_given?
      enum.my_each { |i| return true if yield i }
    else
      enum.my_each { |i| return true if ->(o) { o }.call(i) }
    end
    false
  end

  def my_none?
    enum = to_enum(:none?)
    if block_given?
      enum.my_each { |i| return false if yield i }
    else
      enum.my_each { |i| return false if ->(o) { o }.call(i) }
    end
    true
  end

  def my_count(item = nil)
    enum = to_enum
    count = 0
    if block_given?
      enum.my_each { |i| count += 1 if yield i }
    elsif !item.nil?
      enum.my_each { |i| count += 1 if i == item }
    else
      enum.my_each { |i| count += 1 if i }
    end
    count
  end

  def my_map(arg = nil)
    enum = to_enum
    return enum unless block_given? || !arg.nil?

    if block_given?
      array = []
      enum.my_each { |i| array.push(yield i) }
      array
    elsif arg.instance_of?(Proc)
      array = []
      enum.my_each { |i| array.push(arg.call(i)) }
      array
    end
  end

  def my_inject(arg1 = nil, arg2 = nil)
    symbols = %i[+ - * /]
    enum = to_enum
    return unless block_given? || !arg1.nil?

    if symbols.include?(arg1) && arg2.nil? && !block_given?
      memory = enum.first
      enum = drop(1).to_enum
      enum.my_each { |i| memory += i } if arg1 == :+
      enum.my_each { |i| memory *= i } if arg1 == :*
      enum.my_each { |i| memory -= i } if arg1 == :-
      enum.my_each { |i| memory /= i } if arg1 == :/
    elsif symbols.include?(arg2) && !arg1.nil? && !block_given?
      memory = arg1
      enum.my_each { |i| memory += i } if arg2 == :+
      enum.my_each { |i| memory *= i } if arg2 == :*
      enum.my_each { |i| memory -= i } if arg2 == :-
      enum.my_each { |i| memory /= i } if arg2 == :/
    elsif block_given? && arg1.nil?
      memory = enum.first
      enum = drop(1).to_enum
      enum.my_each { |i| memory = yield memory, i }
    else
      memory = arg1
      enum.my_each { |i| memory = yield memory, i }
    end
    memory
  end
end
