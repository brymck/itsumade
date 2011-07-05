require 'yaml'
require 'itsumade/store'

module Itsumade
  class Manager
    include Enumerable
    YAML_FILENAME = 'data.yml'
    attr_reader :stores

    def initialize
      @stores = []
      load
    end

    def each
      @stores.each { |store| yield store }
    end

    def length
      @stores.length
    end

    def longest_name_length
      longest = 0
      @stores.each do |store|
        longest = store.name.length if longest < store.name.length
      end
      longest
    end

    alias size length

    def sort!
      @stores.sort! { |x, y| x.name <=> y.name }
    end

    def save
      output = File.new(YAML_FILENAME, 'w')
      output.puts YAML.dump(@stores)
      output.close
    end

    alias update save

    def load
      begin
        output = File.new(YAML_FILENAME, 'r')
        @stores = YAML.load(output.read)
        @stores.each { |store| store.observers = [self] }
        output.close
      rescue Errno::ENOENT
        puts 'No stores currently saved.'
      end
    end

    def delete_at(index)
      @stores.delete_at index
      save
    end

    def <<(name)
      @stores << Store.new(name, self)
      save
    end

    def [](index)
      @stores[index]
    end

    def []=(index, name)
      @stores[index] = Store.new(name, self)
      save
    end
  end
end
