module Pori
  class Runner
    attr_reader :args

    def initialize(*args)
      @args = args
    end

    # Shortcut
    def self.execute(*args)
      new(*args).execute
    end

    def execute
      Commands.run(@args)
    end
  end
end
