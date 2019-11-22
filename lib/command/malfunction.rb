# frozen_string_literal: true

module Command
  class Malfunction
    attr_reader :command

    def initialize(command)
      @command = command
    end
  end
end
