module Itsumade
  module TimeBuilder
    class << self
      BASE_YEAR  = 1970
      BASE_MONTH = 1
      BASE_DAY   = 4

      def build(weekday, hour, min)
        # Clean up inputs to allow for hours after midnight
        weekday += hour / 24
        hour = hour % 24

        Time.utc(BASE_YEAR, BASE_MONTH, BASE_DAY + weekday, hour, min)
      end
    end
  end
end
