require_relative 'modules'

def test(test)
  case test
  when 1
    puts 'my_each vs. each'
    arr = [1, 2, 3, 4, 5, 'a', 'b', 'c']
    arr.my_each  { |item| puts item }
    puts '------'
    arr.each { |item| puts item }
    puts '------'
  when 2
    puts 'my_each_with_index vs. each_with_index'
    arr = [1, 2, 3, 4, 5, 'a', 'b', 'c']
    arr.my_each_with_index { |_item, index| puts index }
    puts '------'
    arr.each_with_index { |_item, index| puts index }
    puts '------'
  when 3
    puts 'my_select vs. select'
    arr = [1, 2, 3, 4, 5, 8]
    puts arr.my_select { |item| item.even? }
    puts '------'
    puts arr.select { |item| item.even? }
    puts '------'
  when 4
    puts 'my_all? vs. all?'
    arr = [2, 2, 6, 8, 3]
    puts arr.my_all? { |item| item.even? }
    puts '------'
    puts arr.all? { |item| item.even? }
    puts '------'
  when 5
    puts 'my_any? vs. any?'
    arr = [2, 2, 6, 8, 3]
    puts arr.my_any? { |item| item.odd? }
    puts '------'
    puts arr.any? { |item| item.odd? }
    puts '------'
  when 6
    puts 'my_none? vs. none?'
    arr = [2, 2, 6, 8, 2]
    puts arr.my_none? { |item| item.odd? }
    puts '------'
    puts arr.none? { |item| item.odd? }
    puts '------'
  when 7
    puts 'my_count vs. count'
    arr = [2, 2, 6, 8, 2]
    puts arr.my_count { |item| item.even? }
    puts arr.my_count(2)
    puts arr.my_count
    puts '------'
    puts arr.count { |item| item.even? }
    puts arr.count(2)
    puts arr.count
    puts '------'
  when 8
    puts 'my_map vs. map'
    arr = [2, 2, 6, 8, 2]
    puts arr.my_map { |item| item * 2 }

    puts '------'
    puts arr.map { |item| item * 2 }
    puts '------'
  when 9
    puts 'my_inject vs. inject'
    arr = [2, 2, 6, 8, 2]
    puts arr.my_inject(100) { |sum, n| sum + n }
    puts arr.my_inject { |sum, n| sum + n }
    puts arr.my_inject(5, :*)
    puts arr.my_inject(:*)
    puts '------'
    puts arr.inject(100) { |sum, n| sum + n }
    puts arr.inject { |sum, n| sum + n }
    puts arr.inject(5, :*)
    puts arr.inject(:*)
    puts '------'
  when 10
    puts 'multiples'
    def multiply_els(array = [2, 2, 6, 8, 2])
      array.my_inject(:*)
    end
    puts multiply_els
    puts '------'
  when 11
    puts 'my_map proc'
    proc = proc { |item| item**2 }
    arr = [2, 2, 6, 8, 2]
    puts arr.my_map(proc)
  end
end

12.times do |i|
  test(i)
end
