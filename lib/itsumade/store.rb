require 'itsumade/opening_hours'

module Itsumade
  class Store
    include Enumerable
    attr_accessor :name

    def initialize(name)
      @name = name
      @hours = []
    end

    def each
      @hours.each { |hours| yield hours }
    end

    def length
      @hours.length
    end

    def delete_at(index)
      @hours.delete_at index
    end

    def <<(hours)
      @hours << hours
    end

    def [](index)
      @hours[index]
    end
    
    def []=(index, hours)
      @hours[index] = hours
    end

    def to_s
      name
    end
  end
end
