letters = {
  1 => "a",
  2 => "b",
  3 => "c",
  4 => "d",
  5 => "e",
  6 => "f",
  7 => "g",
  8 => "h",
  9 => "i",
  10 => "j",
  11 => "k",
  12 => "l",
  13 => "m",
  14 => "n",
  15 => "o",
  16 => "p",
  17 => "q",
  18 => "r",
  19 => "s",
  20 => "t",
  21 => "u",
  22 => "v",
  23 => "w",
  24 => "x",
  25 => "y",
  26 => "z"
}

user_str=""
shift_num=nil

def encode(user_str,shift_num,letters)
  array=user_str.chars 
  for a in 0..array.length-1 do 
   key=letters.key(array[a])
    if key
      num = key.to_i + shift_num
      if num>26
      num-=26
      end
      array[a]=letters[num]
    end
  end
  puts ("Here is the result: " + array.join(""))
end

puts "Welcome to our ceaser cipher"
puts "Please enter the phrase you want to encode"
user_str=gets.chomp()
puts "Now enter the shift number"
shift_num=gets.chomp().to_i
encode(user_str,shift_num,letters)