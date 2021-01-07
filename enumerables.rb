module Enumerable  
    def Enumerable.my_each
      yield('hello', 99)
    end

    def Enumerable.my_each_with_index
        yield(['apple', 'banana', 'strawberry', 'pineapple'])
    end

    def Enumerable.my_select
        yield
    end
end

Enumerable.my_each {|str, num| puts str + ' ' + num.to_s} 

Enumerable.my_each_with_index { |fruit| puts fruit[2] }

friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']
Enumerable.my_select  do 
    friends.select {|friend| puts friend unless friend == 'Leo'}
end