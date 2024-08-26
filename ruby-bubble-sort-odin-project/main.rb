def bubble_sort(array)
    swaps=1
    while swaps!=0 do
        swaps=0 
        for a in 0..array.length-1 do 
            if a!=array.length-1
                if array[a]>array[a+1]
                    temp = array[a]
                    array[a]=array[a+1]
                    array[a+1]=temp
                    swaps+=1
                end
            end 
        end
    end
    puts array
end

numbers = Array.new(100000) { rand(1..1000) }

bubble_sort(numbers)