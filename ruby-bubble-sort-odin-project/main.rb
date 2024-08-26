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

array = [3,2,1,5,7,2,1,12,56,23,12,5,4,8,90,13,45,789,45,23,12,45,66,78,89,90,34,21,4,56,78,89,32,21,65,787,9,
            224,678,32,56,98,212,56,343,787,98,323,87,32,90,65,312,789,3312,787,143,8675,33465,76986,4234,123]

bubble_sort(array)
