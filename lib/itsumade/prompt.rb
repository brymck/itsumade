require 'singleton'
require 'itsumade/manager'

module Itsumade
  class Prompt
    def initialize(manager)
      @manager = manager
    end
    
    def run
      while true
        puts "\n"
        i = 0
        @manager.each do |store|
          puts "#{'% 2d' % i}: #{store}"
          i += 1
        end

        puts " a: Add store\n" \
             " x: Exit"
        print 'Your selection: '
        response = gets.chomp
        case response
        when 'a'
          add_store
        when 'x'
          exit
        else
          if response =~ /^[0-9]+$/
            response_index = response.to_i
            if response_index >= 0 && response_index < @manager.length
              edit_store response_index
            end
          end
        end
      end
    end

    private

    def add_hours(index)
      puts " 0: Sunday\n" \
           " 1: Monday\n" \
           " 2: Tuesday\n" \
           " 3: Wednesday\n" \
           " 4: Thursday\n" \
           " 5: Friday\n" \
           ' 6: Saturday'
      print 'Enter your selection: '
      weekday = gets.chomp.to_i
      print 'Enter start hour (0-23+): '
      start_hour = gets.chomp.to_i
      print 'Enter start minute (0-59): '
      start_min = gets.chomp.to_i
      print 'Enter end hour (0-23+): '
      end_hour = gets.chomp.to_i
      print 'Enter end minute (0-59): '
      end_min = gets.chomp.to_i
      @manager[index] << OpeningHours.new(weekday, start_hour, start_min, end_hour, end_min)
      @manager.save
    end

    def add_store
      print 'Enter name: '
      @manager << gets.chomp
      edit_store(@manager.length - 1)
    end

    def edit_store(index)
      while true
        puts "\n"
        puts ANSI.yellow{ ANSI.bold{ @manager[index].name.upcase } }
        i = 0
        @manager[index].each do |hours|
          puts "#{'% 2d' % i}: #{hours}"
          i += 1
        end
        puts " a: Add hours\n" \
             " c: Change name\n" \
             " r: Remove\n" \
             ' x: Exit'
        print 'Your selection: '
        response = gets.chomp
        case response
        when 'a'
          add_hours index
        when 'c'
          print 'Enter name: '
          @manager[index].name = gets.chomp
          @manager.save
        when 'r'
          @manager.delete_at index
          return true
        when 'x'
          return false
        else
          if response =~ /^[0-9]+$/
            response_index = response.to_i
            if response_index >= 0 && response_index < @manager[index].length
              print "Delete #{@manager[index][response_index]}? (Y/N): "
              if gets[0].downcase == 'y'
                @manager[index].delete_at response_index
                @manager.save
              end
            end
          end
        end
      end
    end
  end
end
