require 'itsumade/version'
require 'itsumade/store'
require 'itsumade/manager'
require 'itsumade/prompt'

module Itsumade
  class << self
    attr_reader :manager, :prompt
    def initialize
      @manager = Manager.new
      @prompt = Prompt.new
      @prompt.run
    end
  end
end
