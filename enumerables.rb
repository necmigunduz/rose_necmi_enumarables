module Enumerable  
    def Enumerable.my_each
      yield('hello', 99)
    end

    def Enumerable.my_each_with_index
        yield(['apple', 'banana', 'strawberry', 'pineapple'])
    end

    def Enumerable.my_select
        yield(['Sharon', 'Leo', 'Leila', 'Brian', 'Arun'])
    end

    def Enumerable.my_all?
        yield("a",2,3)
    end

    def Enumerable.my_any?
        yield(2,4)
    end

    def Enumerable.my_none? 
        yield
    end

    def Enumerable.my_count
        yield(Array)
    end

    def Enumerable.my_map
        yield
    end
    
    def Enumerable.my_inject
        sum = 0
        yield([1,2,3,45])
    end
end

Enumerable.my_each {|str, num| puts str + ' ' + num.to_s} 

Enumerable.my_each_with_index { |fruit| puts fruit[2] }

Enumerable.my_select {|friend| puts friend - ["Leo"]}

Enumerable.my_all? { |element| puts element.is_a?(Integer) }

Enumerable.my_any? do |num|
    if num%2 != 0 
        puts "All numbers are odd"
    elsif num%2 != 0 && num%2 == 0
        puts "There is at least one odd and one even number"
    else
        puts "All numbers are even"
    end
end

a = ["an","bearw","aaaaaa"]

Enumerable.my_none?  do
    for word in a
        if word.length >= 5
            puts true
        else
            puts false
        end
    end
end

b = [1,2,3,4,5,"rr"]
Enumerable.my_count do |i|
    counts = 0
    (0...b.length).each do
        if i 
            counts += 1
        end
    end
    puts counts
end

z = ["a","b","c"]

Enumerable.my_map { z.each {|letter| puts letter.upcase } }

d = [1,2,3,4,5]
s = 0
Enumerable.my_inject {d.each {|i|  puts s += i} }