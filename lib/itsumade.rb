require "itsumade/version"

module Itsumade
  class << self
    def application
      @@application ||= nil
    end

    def application=(application)
      @@application = application
    end
  end

  class Store
    def initialize

    end
  end

  class OpeningHours
    SUNDAY    = 0
    MONDAY    = 1
    TUESDAY   = 2
    WEDNESDAY = 3
    THURSDAY  = 4
    FRIDAY    = 5
    SATURDAY  = 6
    SUNDAY    = 7

    def initialize(weekday, start_hour, start_min, end_hour, end_min)
      @range = convert(weekday, start_hour, start_min)..convert(weekday, end_hour, end_min)
    end

    private

    def convert(weekday, hour, min)
      weekday * 60 * 24 + hour * 60 + min
    end
  end

  class MondayHours < OpeningHours

  end
end
