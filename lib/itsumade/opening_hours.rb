module Itsumade
  class OpeningHours
    attr_accessor :start, :end

    def initialize(start_time, end_time)
      @start, @end = start_time, end_time
    end

    def include?(time)
      @start <= time && @end >= time
    end

    def to_s
      # Caches result as @text
      @text ||= "#{@start.strftime('%a: %l:%M %p')} - " \
                "#{@end.strftime('%l:%M %p')}"
    end
  end
end
