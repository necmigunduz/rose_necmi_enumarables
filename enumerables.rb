# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

module Enumerable
  def my_each
    return to_enum unless block_given?

    arr = to_a
    arr.length.times { |e| yield(arr[e]) }
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    arr = to_a
    (0...arr.length).each { |index| yield(arr[index], index) }
    self
  end

  def my_select
    if block_given?
      arr = []

      my_each { |element| arr.push(element) if yield(element) }
      arr
    else
      to_enum(:my_select)
    end
  end

  def my_all?(arg = nil)
    unless arg.nil?
      if arg.is_a? Class
        my_each.each { |element| return false unless element.is_a?(arg) }
      elsif arg.is_a? Regexp
        my_each.each { |element| return false unless element =~ arg }
      else
        my_each.each { |element| return false unless element.is_a(arg) }
      end
      return true
    end

    unless block_given?
      my_each { |element| return false unless element }
      return true
    end

    desired = false

    my_each do |element|
      desired = yield(element)
      break unless desired
    end

    desired
  end

  def my_any?
    if block_given?
      result = []
      my_each { |element| result.push(yield(self[element])) }
      p true if result.include?(true)
      p false if result.include?(false)
    else
      to_enum(:my_any)
    end
  end

  def my_none?
    if block_given?
      result = []
      my_each { |element| result.push(yield(self[element])) }
      p false if result.include?(true)
      p true if result.include?(false)
    else
      to_enum(:my_any)
    end
  end

  def my_count
    if block_given?
      count = 0
      my_each { |element| count += 1 if yield(element) }
      p count
    else
      to_enum(:count)
    end
  end

  def my_map
    if block_given?
      animal = []
      length.times { |_element| animal.push(yield) }
      p animal
    else
      to_enum(:my_map)
    end
  end

  def my_inject(beg = nil, sym = nil)
    if !beg.nil? && !sym.nil?
      my_each { |num| beg = beg.method(sym).call(num) }
    elsif !beg.nil? && beg.is_a?(Symbol) && !sym.nil?
      memo = self
      my_each { |num| memo = memo.method(beg).call(num) }
      memo
    elsif !beg.nil? && beg.is_a?(Integer) && sym.nil?
      my_each { |num| beg = yield(beg, num) }
      beg
    elsif beg.nil? && sym.nil?
      beg, *remain_e = self
      remain_e.my_each { |num| beg = yield(beg, num) }
      beg
    end
  end

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
end

def multiply_els(arr)
  arr.my_inject { |mlt, i| mlt + i }
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
