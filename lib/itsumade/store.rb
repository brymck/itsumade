require 'itsumade/opening_hours'

module Itsumade
  class Store
    attr_reader :name

    def initialize(name)
      @name = name
      @hours = []
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
  end
end
