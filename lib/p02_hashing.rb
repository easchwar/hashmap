class Fixnum
  # Fixnum#hash already implemented for you 
end

class Array
  def hash
    h = 0
    self.each_with_index do |el, i|
      h = (el.hash + i.hash) ^ h
    end
    h
  end
end

class String
  def hash
    ord_array = self.chars.map(&:ord)
    ord_array.hash
  end
end

class Hash
  def hash
    self.to_a.sort.hash 
  end
end
