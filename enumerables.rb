module Enumerable
  # Task-1 my_each exercise
  def my_each
    if block_given?
      length.times { |e| yield(self[e]) }
    else
      to_enumerator(:my_each)
    end
  end
  # Test for my_each
  # [1,2,3].my_each {|e| p "#{e}"}
  # Task-2 my_each_with_index
  def my_each_with_index
    if block_given?
      (0...length).each { |index| yield(self[index], index) }
    else
      to_enumerator(:my_each_with_index)
    end
  end
  # Test for my_each
  # [1,2,3].my_each_with_index {|e,i| p "#{e}:#{i}"}
  # Task-3 my_select
  def my_select
    if block_given?
      arr = []
      (0...self.length).each {|element| arr.push(element) if yield(element)}
      arr
    else
      to_enum(:my_select)
    end
  end
  # Test for my_select
  # p([1, 2, 3, 4, 5, 6, 7, 8].my_select { |x| x.even? })
  # Task 4 my_all
  def my_all
    if block_given?
      result = []
      (0...length).each { |element| result.push(yield(self[element])) }
      p false if result.include?(false)
      p true if result.include?(true)
    else
      to_enumerator(:my_all)
    end
  end
  # Test for my_all
  # [1, 2, 3, 4, 5, 6, 7, 8].my_all {|x| x.even?}
  # Task-5 my_any
  def my_any
    if block_given?
      result = []
      (0...length).each { |element| result.push(yield(self[element])) }
      p true if result.include?(true)
      p false if result.include?(false)
    else
      to_enumerator(:my_any)
    end
  end
  # Test for my_any
  # [1, 2, 3, 4, 5, 6, 7, 8].my_any { |x| x.even? }
  # Task-6 my_none
  def my_none
    if block_given?
      result = []
      (0...length).each { |element| result.push(yield(self[element])) }
      p false if result.include?(true)
      p true if result.include?(false)
    else
      to_enumerator(:my_any)
    end
  end
  # Test for my_none
  # [2,4].my_none { |x| x.even? }
  # Task-6 my_count
  def my_count
    if block_given?
      count = 0
      (0...length).each { |element| count += 1 if yield(element) }
      p count
    else
      to_enumerator(:count)
    end
  end
  # Test for my_count
  # [1, 2, 3, 4, 5, 6, 7, 8, 0, nil].my_count {|x| x.even?}
  # Task-7 my_map
  def my_map
    if block_given?
      animal = []
      length.times { |_element| animal.push(yield) }
      p animal
    else
      to_enumerator(:my_map)
    end
  end
  # Test for my_map
  # [1, 2, 3, 4, 5, 6, 7, 8].my_map {"cat"}
  # Task-8 my_inject
  def my_inject(starter = nil, sym = nil)
    if !starter.nil? && !sym.nil?
      my_each { |num| starter = starter.method(sym).call(num) } # = starter += self[num]
      starter
    elsif !starter.nil? && starter.is_a?(Symbol) && !sym.nil?
      memo = self
      my_each { |num| memo = memo.method(starter).call(num) }
      memo
    elsif !starter.nil? && starter.is_a?(Integer) && sym.nil?
      my_each { |num| starter = yield(starter, num) }
      starter
    elsif starter.nil? && sym.nil?
      starter, *remaining_ele = self
      remaining_ele.my_each { |num| starter = yield(starter, num) }
      starter
    end
  end
  # Test for my_inject
  # p [2, 4, 5].my_inject(1, :*)
  # p [2, 4, 5].my_inject(:*)
  # p [2, 4, 5].my_inject(2) { |memo, n| memo * n }
  # p [2, 4, 5].my_inject { |memo, n| memo + n }
  # Task-10 my_map_proc
  def my_map_proc
    arr = []
    if block_given?
      my_each do |x|
        arr.push(yield(x))
      end
    else
      to_enum(:my_map_proc)
    end
    arr
  end
  # Test for my_map_proc
  # my_pr = proc { |x| x + 20 }
  # p [1, 2, 3, 4, 5].my_map_proc(&my_pr)
end
# Task-9 multiply_els
def multiply_els(arr)
  arr.my_inject { |mlt, i| mlt + i }
end
# Test for multiply_els
# p multiply_els([2, 4, 5])
