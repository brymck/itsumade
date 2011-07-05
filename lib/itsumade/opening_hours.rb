module Itsumade
  class OpeningHours
    BASE_YEAR  = 1970
    BASE_MONTH = 1
    BASE_DAY   = 4

    def initialize(weekday, start_hour, start_min, end_hour, end_min)
      @start = build_time(weekday, start_hour, start_min)
      @end = build_time(weekday, end_hour, end_min)
    end

    def include?(weekday, hour, min)
      compare_time = build_time(weekday, hour, min)
      @start <= compare_time && @end >= compare_time
    end

    def to_s
      # Allows lazy creation of @text
      @text ||= "#{@start.strftime('%a: %I:%M %p')} - " \
                "#{@end.strftime('%I:%M %p')}".gsub(/0([1-9]:)/, ' \1')
    end

    private

    def build_time(weekday, hour, min)
      Time.utc(BASE_YEAR, BASE_MONTH, BASE_DAY + weekday, hour, min)
    end
  end
end
