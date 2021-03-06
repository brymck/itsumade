require 'ansi/code'
require 'yaml'
require 'itsumade/version'
require 'itsumade/time_builder'
require 'itsumade/store'
require 'itsumade/manager'
require 'itsumade/prompt'

module Itsumade
  class << self
    attr_reader :manager, :prompt

    def run
      @manager ||= Manager.new
      @prompt  ||= Prompt.new(@manager)
      @prompt.run
    end
  end
end

Itsumade.run
