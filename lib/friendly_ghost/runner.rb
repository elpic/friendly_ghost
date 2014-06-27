require 'posix/spawn'
require 'multi_json'

module FriendlyGhost
  class Runner
    include POSIX::Spawn

    attr_accessor :casper_path
    attr_reader :process, :result

    def initialize
      @casper_path = `which casperjs`.strip
    end

    def command(args)
      @process = Child.new("#{@casper_path} #{args}")

      @result = {}
      @result['output'] = @process.out
      @result['error']  = @process.err
      @result['status'] = @process.success?

      @result
    end

    def raw_output
      @process.out
    end
  end
end
