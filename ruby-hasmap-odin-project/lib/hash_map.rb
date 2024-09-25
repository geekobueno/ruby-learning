class HashMap
  LOAD_FACTOR = 0.75

  def initialize
    @buckets = Array.new(16) { [] } # Create an array with empty buckets
    @size = 0
  end

  # A simple hash method using a prime number
  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  # This sets a key-value pair into the hash map
  def set(key, value)
    # Check if the load factor threshold is exceeded and resize if needed
    resize if @size.to_f / @buckets.length > LOAD_FACTOR

    bucket_index = hash(key) % @buckets.length
    bucket = @buckets[bucket_index]

    # Check if the key already exists in the bucket
    bucket.each do |pair|
      if pair[0] == key
        pair[1] = value # Overwrite the value
        return
      end
    end

    # If key doesn't exist, add the new key-value pair
    bucket << [key, value]
    @size += 1
  end

  # This returns the value associated with a key
  def get(key)
    bucket_index = hash(key) % @buckets.length
    bucket = @buckets[bucket_index]

    bucket.each do |pair|
      return pair[1] if pair[0] == key
    end

    nil
  end

  # This checks if a key exists in the hash map
  def has?(key)
    bucket_index = hash(key) % @buckets.length
    bucket = @buckets[bucket_index]

    bucket.each do |pair|
      return true if pair[0] == key
    end

    false
  end

  # This removes a key-value pair from the hash map
  def remove(key)
    bucket_index = hash(key) % @buckets.length
    bucket = @buckets[bucket_index]

    bucket.each_with_index do |pair, index|
      if pair[0] == key
        bucket.delete_at(index)
        @size -= 1
        return pair[1] # Return the removed value
      end
    end

    nil
  end

  # This returns the number of key-value pairs in the hash map
  def length
    @size
  end

  # This clears the hash map of all entries
  def clear
    @buckets = Array.new(16) { [] }
    @size = 0
  end

  # This returns all the keys in the hash map
  def keys
    all_keys = []
    @buckets.each do |bucket|
      bucket.each { |pair| all_keys << pair[0] }
    end
    all_keys
  end

  # This returns all the values in the hash map
  def values
    all_values = []
    @buckets.each do |bucket|
      bucket.each { |pair| all_values << pair[1] }
    end
    all_values
  end

  # This returns all the key-value pairs in the hash map
  def entries
    all_entries = []
    @buckets.each do |bucket|
      bucket.each { |pair| all_entries << pair }
    end
    all_entries
  end

  private

  # This resizes the hash map when it exceeds the load factor
  def resize
    old_buckets = @buckets
    @buckets = Array.new(@buckets.length * 2) { [] }
    @size = 0

    old_buckets.each do |bucket|
      bucket.each do |pair|
        set(pair[0], pair[1]) # Re-hash each existing key-value pair
      end
    end
  end
end
