require 'singleton'
require 'itsumade/manager'

module Itsumade
  class Prompt
    DAYS = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday',
            'Friday', 'Saturday', 'Weekdays', 'Weekends']

    def initialize(manager)
      @manager = manager
    end
    
    def run
      while true
        breadcrumbs
        list_options @manager

        puts " a: Add store\n" \
             " x: Exit"
        response = get_response('Your selection: ')
        case response
        when 'a'
          add_store
        when 'x'
          exit
        else
          edit_store(response.to_i) if valid_index?(response, @manager.length)
        end
      end
    end

    private

    def breadcrumbs(*crumbs)
      puts "\n"
      crumbs.unshift 'itsumade'
      puts ANSI.yellow + ANSI.bold + crumbs.join(' > ').upcase + ANSI.clear
    end

    def list_options(options, indent = nil)
      i = 0
      options.each do |option|
        puts "#{'% 2d' % i}: #{option}"
        i += 1
      end
    end

    def get_response(text)
      print ANSI.bold + text + ANSI.clear
      gets.chomp
    end

    def valid_index?(response, length)
      if response =~ /^[0-9]+$/
        response_index = response.to_i
        return response_index >= 0 && response_index < length
      else
        return false
      end
    end

    def add_hours(index)
      breadcrumbs @manager[index].name, 'add hours'
      list_options DAYS
      weekdays   = get_response('Enter your selection:      ').to_i
      start_hour = get_response('Enter start hour (0-23+):  ').to_i
      start_min  = get_response('Enter start minute (0-59): ').to_i
      end_hour   = get_response('Enter start hour (0-23+):  ').to_i
      end_min    = get_response('Enter start minute (0-59): ').to_i
      
      case weekdays
      when 7 # All weekdays
        weekdays = [1, 2, 3, 4, 5]
      when 8 # All weekend
        weekdays = [0, 6]
      else
        weekdays = [weekdays]
      end

      weekdays.each do |weekday|
        @manager[index] << OpeningHours.new(TimeBuilder.build(weekday, start_hour, start_min),
                                            TimeBuilder.build(weekday, end_hour, end_min))
      end
    end

    def add_store
      @manager << get_response('Enter name: ')
      edit_store(@manager.length - 1)
    end

    def edit_store(index)
      while true
        breadcrumbs @manager[index].name
        list_options @manager[index]
        puts " a: Add hours\n" \
             " c: Change name\n" \
             " r: Remove\n" \
             ' x: Exit'
        response = get_response('Your selection: ')
        case response
        when 'a'
          add_hours index
        when 'c'
          @manager[index].name = get_response('Enter name: ')
        when 'r'
          @manager.delete_at index
          return true
        when 'x'
          @manager.sort!
          return false
        else
          if valid_index?(response, @manager[index].length)
            print "Delete #{@manager[index][response.to_i]}? (Y/N): "
            @manager[index].delete_at(response.to_i) if gets[0].downcase == 'y'
          end
        end
      end
    end
  end
end
