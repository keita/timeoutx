require 'singleton'

class TimeoutX
  module Version #:nodoc:
    MAJOR = 0
    MINOR = 2
    TINY  = 1

    STRING = [MAJOR, MINOR, TINY].join('.')
  end

  VERSION = Version::STRING

  include Singleton

  attr_accessor :interval
  attr_reader :thread
  attr_reader :table

  def initialize #:nodoc:
    @table = {}
    @interval = 0.5
    @thread = Thread.start do
      while true
        sleep(@interval)
        countdown
      end
    end
  end

  # Sets the interval second of intrenal countdown loop.
  def self.set_interval(sec)
    instance.interval = sec
  end

  def countdown #:nodoc:
    @table.each do |th, attr|
      attr[0] -= @interval
      if attr[0] <= 0
        th.raise(attr[1], "execution expired") if th.alive?
        @table.delete(th)
      end
    end
  end

  def self.append(th, sec, exception) #:nodoc:
    instance.table[th] = [sec, exception]
  end

  def self.delete(th) #:nodoc:
    instance.table.delete(th)
  end

  # Same as Timeout#timeout.
  def self.timeout(sec, exception=TimeoutX::Error)
    append(Thread.current, sec, exception)
    begin
      yield if block_given?
    rescue => ex
      raise(ex)
    ensure
      delete(Thread.current)
    end
  end

  # Replaces Timeout.timeout into TimeoutX.timeout.
  def self.replace_timeout
    require "timeout"
    def Timeout.timeout(sec, exception=Timeout::Error) #:nodoc:
      TimeoutX.timeout(sec, exception)
    end
  end

  # Raised by TimeoutX#timeout when the block times out.
  class Error < Interrupt; end
end
