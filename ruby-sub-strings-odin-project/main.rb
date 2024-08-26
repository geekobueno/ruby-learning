def substrings(text, dictionary)
    result = Hash.new(0)
    words = text.downcase.split(/\W+/)
    
    words.each do |word|
      dictionary.each do |substr|
        if word.include?(substr.downcase)
          result[substr] += 1
        end
      end
    end
    
    result
  end
  
  # Test cases
  dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
  
  puts substrings("Howdy partner, sit down! How's it going?", dictionary)