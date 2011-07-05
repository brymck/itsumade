require 'itsumade/ansi'
require 'itsumade/opening_hours'

module Itsumade
  class Store
    include Ansi
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

    def to_s
      name.red
    end
  end
end
