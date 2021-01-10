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

  def my_all?(argm = nil)
    if block_given?
      to_a.my_each { |i| false if yield(i) == false }

      return true
    elsif argm.nil?
      to_a.my_each { |i| false if i.nil? || i == false }

    elsif !argm.nil? && (argm.is_a? Class)
      to_a.my_each { |i| false unless [i.class, i.class.superclass].include?(arg) }
    elsif !argm.nil? && (argm.is_a? Regexp)
      to_a.my_each { |i| false unless i.match(argm) }
    else
      to_a.my_each { |i| false if i != argm }
    end
    true
  end

  def my_any?(argm = nil)
    return true if !block_given? && argm.nil? && my_each { |elem| return true if elem == true } && empty? == false
    return false unless block_given? || !argm.nil?

    if block_given?
      my_each { |element| return true if yield(element) }
    elsif argm.class == Regexp
      my_each { |element| return true unless argm.match(element).nil? }
    elsif argm.class <= Numeric || argm.class <= String
      my_each { |element| return true if element == argm }
    else
      my_each { |element| return true if element.class != argm }
    end
    false
  end

  def my_none?(argm = nil, &proc)
    !my_any?(argm, &proc)
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      to_a.my_each { |i| count += 1 if yield i }
    elsif !arg.nil?
      to_a.my_each { |i| count += 1 if i == arg }
    else
      to_a.my_each { |i| count += 1 if i }
    end
    count
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given?

    result = []
    my_each { |element| result << proc.call(element) } if block_given? && proc
    my_each { |element| result << yield(element) } if proc.nil?
    result
  end

  def my_inject(memory = nil, symbol = nil, &proc)
    memory = memory.to_sym if memory.is_a?(String) && !symbol && !proc
    raise LocalJumpError if !block_given? && number.nil? && symbol.nil?
    
    if memory.is_a?(Symbol) && !symbol
      proc = memory.to_proc
      memory = nil
    end

    symbol = sym.to_sym if symbol.is_a?(String)
    proc = symbol.to_proc if symbol.is_a?(Symbol)

    my_each { |element| memory = memory.nil? ? element : proc.yield(memory, element) }
    memory
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
  arr.my_inject { |multiply, element| multiply * element }
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
