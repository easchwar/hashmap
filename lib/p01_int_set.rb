class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    raise "out of bounds" unless is_valid?(num)
    return nil unless include?(num)
    @store[num] = false
    num
  end

  def include?(num)
    raise "out of bounds" unless is_valid?(num)
    @store[num]
  end

  private 

  def is_valid?(num)
    num < @store.length && num >= 0
  end
end


class IntSet
  def initialize(length = 8)
    @store = Array.new(length) { Array.new }
  end

  def insert(num)
    return true if include?(num)
    self[num].push(num)
    num
  end

  def remove(num)
    return nil unless include?(num)
    self[num].delete(num)
    num
  end

  def include?(num)
    self[num].include?(num) 
  end

  private
  def [](num)
    @store[num % @store.length]
  end
end

class ResizingIntSet
  def initialize(length = 8)
    @length = length
    @store = Array.new(length) { Array.new }
    @count = 0 
  end

  def insert(num)
    return true if include?(num)
    maybe_resize
    self[num].push(num)
    @count += 1

    num
  end

  def remove(num)
    return nil unless include?(num)
    self[num].delete(num)
    num
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  attr_reader :count, :length, :store

  def maybe_resize
    resize! if count >= length
  end

  def resize!
    old_store = store
    @length *= 2
    @count = 0
    @store = Array.new(length) { Array.new }
    
    old_store.flatten.each { |num| insert(num) }
  end

  def [](num)
    store[num % store.length]
  end
end
