# Task-1 my_each exercise

module Enumerable
  def my_each
    if block_given?
      self.length.times {|e| yield(self[e])}
    else
      to_enumerator(:my_each)
    end
  end

# Test for my_each
# [1,2,3].my_each {|e| p "#{e}"}
      
# Task-2 my_each_with_index

def my_each_with_index
  if block_given?
    (0...self.length).each {|index| yield(self[index],index)}
  else
    to_enumerator(:my_each_with_index)
  end
end

# Test for my_each
# [1,2,3].my_each_with_index {|e,i| p "#{e}:#{i}"}

# Task-3 my_select
def my_select
  if block_given?
    arr=Array.new
    for element in self do
      arr.push(element) if yield(element)
    end
    arr
  else
    to_enum(:my_select)
  end
end

# Test for my_select
 p([1, 2, 3, 4, 5, 6, 7, 8].my_select { |x| x.even? })




end