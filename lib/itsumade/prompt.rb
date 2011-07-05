require 'singleton'

module Itsumade
  class Prompt
    def initialize

    end

    def run
      while true
        puts "1: Add store\n" \
             "2: Edit store\n" \
             "0: Exit"
        print 'Your selection: '
        response = gets.chomp
        case response
        when '1'
          add_store
        when '2'
          edit_store
        when '0'
          exit
        end
      end
    end

    private

    def add_store

    end

    def edit_store

    end
  end
end
