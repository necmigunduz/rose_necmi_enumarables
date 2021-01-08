# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

module Enumerable
  def my_each
    if block_given?
      length.times { |e| yield(self[e]) }
    else
      to_enumerator(:my_each)
    end
  end

  def my_each_with_index
    if block_given?
      (0...length).each { |index| yield(self[index], index) }
    else
      to_enumerator(:my_each_with_index)
    end
  end

  def my_select
    if block_given?
      arr = []
      (0...length).each { |element| arr.push(element) if yield(element) }
      arr
    else
      to_enum(:my_select)
    end
  end

  def my_all?
    if block_given?
      result = []
      (0...length).each { |element| result.push(yield(self[element])) }
      p false if result.include?(false)
      p true if result.include?(true)
    else
      to_enumerator(:my_all)
    end
  end

  def my_any?
    if block_given?
      result = []
      (0...length).each { |element| result.push(yield(self[element])) }
      p true if result.include?(true)
      p false if result.include?(false)
    else
      to_enumerator(:my_any)
    end
  end

  def my_none?
    if block_given?
      result = []
      (0...length).each { |element| result.push(yield(self[element])) }
      p false if result.include?(true)
      p true if result.include?(false)
    else
      to_enumerator(:my_any)
    end
  end

  def my_count
    if block_given?
      count = 0
      (0...length).each { |element| count += 1 if yield(element) }
      p count
    else
      to_enumerator(:count)
    end
  end

  def my_map
    if block_given?
      animal = []
      length.times { |_element| animal.push(yield) }
      p animal
    else
      to_enumerator(:my_map)
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
