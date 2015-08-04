require_relative './p01_int_set'
require_relative './p01_interlude_hashing'

class HashSet < ResizingIntSet
  def initialize(size = 8)
    @store = Array.new(size) { Array.new }
    @count = 0
  end

  def insert(key)
    return true if include?(key)
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

  def length
    store.length
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
