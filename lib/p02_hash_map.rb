require_relative './p01_int_set'
require_relative './p01_interlude_hashing'

class HashSet 
  def initialize(size = 8)
    @store = Array.new(size) { Array.new }
    @count = 0
  end

  def insert(key)
    return true if include?(key)
    maybe_resize

    self[key.hash].push(key)
    @count += 1

    key
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    return nil unless include?(key)
    self[key.hash].delete(key)
  end

  private
  attr_reader :store, :count

  def length
    store.length
  end

  def maybe_resize
    resize! if length < count
  end

  def resize!
    old_store = store
    @count = 0
    @store = Array.new(length * 2) { Array.new }

    old_store.flatten.each { |key| insert(key) }
  end

  def [](num)
    store[num % length]
  end
end

class HashMap
  def initialize(size = 8)
    @store = Array.new(size) { Array.new }
    @count = 0
  end

  def include?(key)
    self[key.hash].any? do |pair| 
      pair.first == key
    end
  end

  def set(key, val)
    remove(key) if include?(key)
    maybe_resize

    self[key.hash].push([key, val])
    @count += 1

    key
  end

  def get(key)
    return nil unless include?(key)

    pair = self[key.hash].find do |pair|
      pair.first == key
    end

    pair.last
  end

  def remove(key)
    return nil unless include?(key)

    val = get(key)

    self[key.hash].delete_if do |pair| 
      pair.first == key
    end
    
    @count -= 1
    val
  end

  private
  attr_reader :store, :count

  def length
    store.length
  end

  def maybe_resize
    resize! if length < count
  end

  def resize!
    old_store = store
    @count = 0
    @store = Array.new(length * 2) { Array.new }

    old_store.each do |bucket|
      bucket.each { |pair| set(pair.first, pair.last) }
    end
  end

  def [](num)
    store[num % length]
  end
end
