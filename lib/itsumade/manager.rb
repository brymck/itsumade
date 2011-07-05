require 'yaml'
require 'itsumade/store'

module Itsumade
  class Manager
    include Enumerable
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
        name_length = store.name.length
        if name_length > longest
          longest = name_length
        end
      end
      longest
    end

    alias size length

    def save
      output = File.new('data.yml', 'w')
      output.puts YAML.dump(@stores)
      output.close
    end

    def load
      begin
        output = File.new('data.yml', 'r')
        @stores = YAML.load(output.read)
        output.close
      rescue
        puts 'No stores currently saved.'
      end
    end

    def delete_at(index)
      @stores.delete_at index
      save
    end

    def <<(name)
      @stores << Store.new(name)
      save
    end

    def [](index)
      @stores[index]
    end

    def []=(index, name)
      @stores[index] = Store.new(name)
      save
    end
  end
end
