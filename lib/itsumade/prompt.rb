require 'singleton'
require 'itsumade/manager'

module Itsumade
  class Prompt
    def initialize(manager)
      @manager = manager
    end
    
    def run
      while true
        i = 1
        @manager.each do |store|
          puts "#{'% 2d' % i}: #{store}"
          i += 1
        end

        puts "a: Add store\n" \
             "x: Exit"
        print 'Your selection: '
        response = gets.chomp
        case response
        when 'a'
          add_store
        when 'x'
          exit
        else
          puts 'hi'
        end
      end
    end

    private

    def add_store
      print 'Enter name: '
      @manager << gets.chomp
      edit_store
    end

    def edit_store
      puts @manager.stores
    end
  end
end
