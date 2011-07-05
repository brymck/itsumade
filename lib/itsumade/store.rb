require 'observer'
require 'itsumade/opening_hours'

module Itsumade
  class Store
    include Enumerable
    include Observable
    attr_accessor :observers
    attr_reader :name

    def initialize(name, manager)
      @name = name
      @hours = []
      @observers = [ manager ]
    end

    def name=(new_name)
      @name = new_name
      changed
      notify_observers
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
      changed
      notify_observers
    end

    def <<(hours)
      @hours << hours
      @hours.sort! { |x, y| x.start <=> y.start }
      changed
      notify_observers
    end

    def [](index)
      @hours[index]
    end
    
    def []=(index, hours)
      @hours[index] = hours
      changed
      notify_observers
    end

    def notify_observers
      @observers.each do |observer|
        observer.update
      end
    end

    def status
      now = Time.now
      relative = TimeBuilder.build(now.wday, now.hour, now.min)
      @hours.each do |hours|
        if hours.end > relative
          if hours.start < relative
            return ANSI.green + "open until #{hours.end.strftime('%l:%M %p').gsub(/^\s/, '')}" + ANSI.clear
          else
            return ANSI.red + "closed until #{hours.start.strftime('%l:%M %p').gsub(/^\s/, '')}" + ANSI.clear
          end
        end
      end
      return ""
    end

    def to_s
      "#{name} - #{status}"
    end
  end
end
