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
end

Enumerable.my_each {|str, num| puts str + ' ' + num.to_s} 

Enumerable.my_each_with_index { |fruit| puts fruit[2] }

Enumerable.my_select {|friend| puts friend - ["Leo"]}

Enumerable.my_all? { |element| puts element.is_a?(Integer) }