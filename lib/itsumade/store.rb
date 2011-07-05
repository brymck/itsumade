require 'itsumade/opening_hours'

module Itsumade
  class Store
    include Enumerable
    attr_accessor :name
    BAR_LENGTH_IN_DAYS = 1

    def initialize(name)
      @name = name
      @hours = []
    end

    def bar
      str = ANSI.red
      has_match = false
      now = Time.now
      relative = OpeningHours.new(now.wday, now.hour, now.min, now.hour + BAR_LENGTH_IN_DAYS * 24, now.min)
      while relative.start < relative.end
        if include?(relative.start.wday, relative.start.hour, relative.start.min)
          if !has_match
            has_match = true
            str += ANSI.clear + ANSI.green
          end
          str += '|'
        else
          if has_match
            has_match = false
            str += ANSI.clear + ANSI.red
          end
          str += '.'
        end
        relative.start += 60 * 60
      end
      str += ANSI.clear
    end

    def each
      @hours.each { |hours| yield hours }
    end

    def include?(weekday, hour, minute)
      @hours.each do |hours|
        if hours.include?(weekday, hour, minute)
          return true
        end
      end
      false
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
