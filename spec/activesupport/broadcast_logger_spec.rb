# frozen_string_literal: true

RSpec.describe ActiveSupport::BroadcastLogger do
  class CustomLogger
    attr_reader :adds, :closed, :chevrons
    attr_accessor :level, :progname, :formatter, :local_level

    def initialize
      @adds = []
      @closed = false
      @chevrons = []
      @level = ::Logger::DEBUG
      @local_level = ::Logger::DEBUG
      @progname = nil
      @formatter = nil
    end

    def foo
      true
    end

    def bar
      yield
    end

    def baz(param)
      true
    end

    def qux(param:)
      true
    end

    def debug(message = nil, &block)
      add(::Logger::DEBUG, message, &block)
    end

    def info(message = nil, &block)
      add(::Logger::INFO, message, &block)
    end

    def warn(message = nil, &block)
      add(::Logger::WARN, message, &block)
    end

    def error(message = nil, &block)
      add(::Logger::ERROR, message, &block)
    end

    def fatal(message = nil, &block)
      add(::Logger::FATAL, message, &block)
    end

    def unknown(message = nil, &block)
      add(::Logger::UNKNOWN, message, &block)
    end

    def <<(x)
      @chevrons << x
    end

    def add(message_level, message = nil, progname = nil, &block)
      @adds << [message_level, block_given? ? block.call : message, progname] if message_level >= local_level
      true
    end

    def debug?
      level <= ::Logger::DEBUG
    end

    def info?
      level <= ::Logger::INFO
    end

    def warn?
      level <= ::Logger::WARN
    end

    def error?
      level <= ::Logger::ERROR
    end

    def fatal?
      level <= ::Logger::FATAL
    end

    def close
      @closed = true
    end
  end

  class FakeLogger < CustomLogger
    include ActiveSupport::LoggerSilence

    # LoggerSilence includes LoggerThreadSafeLevel which defines these as
    # methods, so we need to redefine them
    attr_accessor :level, :local_level
  end

  class KwargsAcceptingLogger < CustomLogger
    Logger::Severity.constants.each do |level_name|
      method = level_name.downcase
      define_method(method) do |message, **kwargs|
        add(Logger::Severity.const_get(level_name), "#{kwargs.inspect} #{message}")
      end
    end

    def add(severity, message = nil, **kwargs)
      return super(severity, "#{kwargs.inspect} #{message}") if kwargs.present?
      super
    end
  end

  before do
    @log1 = FakeLogger.new
    @log2 = FakeLogger.new
    @logger = described_class.new(@log1, @log2)
  end

  Logger::Severity.constants.each do |level_name|
    method = level_name.downcase
    level = Logger::Severity.const_get(level_name)

    it "##{method} adds the message to all loggers" do
      @logger.public_send(method, "msg")

      assert_equal [level, "msg", nil], @log1.adds.first
      assert_equal [level, "msg", nil], @log2.adds.first
    end
  end

  it "#close broadcasts to all loggers" do
    @logger.close

    assert @log1.closed, "should be closed"
    assert @log2.closed, "should be closed"
  end

  it "#<< shovels the value into all loggers" do
    @logger << "foo"

    assert_equal %w{foo}, @log1.chevrons
    assert_equal %w{foo}, @log2.chevrons
  end

  it "#level= assigns the level to all loggers" do
    assert_equal Logger::DEBUG, @log1.level
    @logger.level = Logger::FATAL

    assert_equal Logger::FATAL, @log1.level
    assert_equal Logger::FATAL, @log2.level
  end

  it "#level returns the level of the logger with the lowest level" do
    @log1.level = Logger::DEBUG

    assert_equal(Logger::DEBUG, @logger.level)

    @log1.level = Logger::FATAL
    @log2.level = Logger::INFO

    assert_equal(Logger::INFO, @logger.level)
  end

  it "#progname returns Broadcast literally when the user didn't change the progname" do
    assert_equal("Broadcast", @logger.progname)
  end

  it "#progname= sets the progname on the Broadcast logger but doesn't modify the inner loggers" do
    assert_nil(@log1.progname)
    assert_nil(@log2.progname)

    @logger.progname = "Foo"

    assert_equal("Foo", @logger.progname)
    assert_nil(@log1.progname)
    assert_nil(@log2.progname)
  end

  it "#formatter= assigns to all the loggers" do
    @logger.formatter = Logger::FATAL

    assert_equal Logger::FATAL, @log1.formatter
    assert_equal Logger::FATAL, @log2.formatter
  end

  it "#local_level= assigns the local_level to all loggers" do
    assert_equal Logger::DEBUG, @log1.local_level
    @logger.local_level = Logger::FATAL

    assert_equal Logger::FATAL, @log1.local_level
    assert_equal Logger::FATAL, @log2.local_level
  end

  context "with stop broadcasting" do
    let(:anon_logger) do
      Class.new(Logger) do
        attr_reader :info_called

        def info(msg, &block)
          @info_called = true
        end
      end
    end
    let(:my_logger) do
      anon_logger.new(StringIO.new)
    end

    after do
      @logger.stop_broadcasting_to(my_logger)
    end

    it "severity methods get called on all loggers" do
      @logger.broadcast_to(my_logger)

      expect { @logger.info("message") }.to change { my_logger.info_called }.from(nil).to(true)
    end
  end

  it "#silence does not break custom loggers" do
    new_logger = FakeLogger.new
    custom_logger = CustomLogger.new
    assert_respond_to new_logger, :silence
    assert_not_respond_to custom_logger, :silence

    logger = described_class.new(custom_logger, new_logger)

    logger.silence do
      logger.error "from error"
      logger.unknown "from unknown"
    end

    assert_equal [[Logger::ERROR, "from error", nil], [Logger::UNKNOWN, "from unknown", nil]], custom_logger.adds
    assert_equal [[Logger::ERROR, "from error", nil], [Logger::UNKNOWN, "from unknown", nil]], new_logger.adds
  end

  it "#silence silences all loggers below the default level of ERROR" do
    @logger.silence do
      @logger.debug "test"
    end

    assert_equal [], @log1.adds
    assert_equal [], @log2.adds
  end

  it "#silence does not silence at or above ERROR" do
    @logger.silence do
      @logger.error "from error"
      @logger.unknown "from unknown"
    end

    assert_equal [[Logger::ERROR, "from error", nil], [Logger::UNKNOWN, "from unknown", nil]], @log1.adds
    assert_equal [[Logger::ERROR, "from error", nil], [Logger::UNKNOWN, "from unknown", nil]], @log2.adds
  end

  it "#silence allows you to override the silence level" do
    @logger.silence(Logger::FATAL) do
      @logger.error "unseen"
      @logger.fatal "seen"
    end

    assert_equal [[Logger::FATAL, "seen", nil]], @log1.adds
    assert_equal [[Logger::FATAL, "seen", nil]], @log2.adds
  end

  it "stop broadcasting to a logger" do
    @logger.stop_broadcasting_to(@log2)

    @logger.info("Hello")

    assert_equal([[1, "Hello", nil]], @log1.adds)
    assert_empty(@log2.adds)
  end

  it "#broadcast on another broadcasted logger" do
    @log3 = FakeLogger.new
    @log4 = FakeLogger.new
    @broadcast2 = described_class.new(@log3, @log4)

    @logger.broadcast_to(@broadcast2)
    @logger.info("Hello")

    assert_equal([[1, "Hello", nil]], @log1.adds)
    assert_equal([[1, "Hello", nil]], @log2.adds)
    assert_equal([[1, "Hello", nil]], @log3.adds)
    assert_equal([[1, "Hello", nil]], @log4.adds)
  end

  it "#debug? is true when at least one logger's level is at or above DEBUG level" do
    @log1.level = Logger::DEBUG
    @log2.level = Logger::FATAL

    assert_predicate(@logger, :debug?)
  end

  it "#debug? is false when all loggers are below DEBUG level" do
    @log1.level = Logger::ERROR
    @log2.level = Logger::FATAL

    assert_not_predicate(@logger, :debug?)
  end

  it "#info? is true when at least one logger's level is at or above INFO level" do
    @log1.level = Logger::DEBUG
    @log2.level = Logger::FATAL

    assert_predicate(@logger, :info?)
  end

  it "#info? is false when all loggers are below INFO" do
    @log1.level = Logger::ERROR
    @log2.level = Logger::FATAL

    assert_not_predicate(@logger, :info?)
  end

  it "#warn? is true when at least one logger's level is at or above WARN level" do
    @log1.level = Logger::DEBUG
    @log2.level = Logger::FATAL

    assert_predicate(@logger, :warn?)
  end

  it "#warn? is false when all loggers are below WARN" do
    @log1.level = Logger::ERROR
    @log2.level = Logger::FATAL

    assert_not_predicate(@logger, :warn?)
  end

  it "#error? is true when at least one logger's level is at or above ERROR level" do
    @log1.level = Logger::DEBUG
    @log2.level = Logger::FATAL

    assert_predicate(@logger, :error?)
  end

  it "#error? is false when all loggers are below ERROR" do
    @log1.level = Logger::FATAL
    @log2.level = Logger::FATAL

    assert_not_predicate(@logger, :error?)
  end

  it "#fatal? is true when at least one logger's level is at or above FATAL level" do
    @log1.level = Logger::DEBUG
    @log2.level = Logger::FATAL

    assert_predicate(@logger, :fatal?)
  end

  it "#fatal? is false when all loggers are below FATAL" do
    @log1.level = Logger::UNKNOWN
    @log2.level = Logger::UNKNOWN

    assert_not_predicate(@logger, :fatal?)
  end

  it "calling a method that no logger in the broadcast have implemented" do
    assert_raises(NoMethodError) do
      @logger.non_existing
    end
  end

  it "calling a method when *one* logger in the broadcast has implemented it" do
    logger = described_class.new(CustomLogger.new)

    assert(logger.foo)
  end

  it "calling a method when *multiple* loggers in the broadcast have implemented it" do
    logger = described_class.new(CustomLogger.new, CustomLogger.new)

    assert_equal([true, true], logger.foo)
  end

  it "calling a method when a subset of loggers in the broadcast have implemented" do
    logger = described_class.new(CustomLogger.new, FakeLogger.new)

    assert(logger.foo)
  end

  it "methods are called on each logger" do
    calls = 0
    loggers = [CustomLogger.new, FakeLogger.new, CustomLogger.new].each do |logger|
      logger.define_singleton_method(:special_method) do
        calls += 1
      end
    end
    logger = described_class.new(*loggers)
    logger.special_method
    assert_equal(3, calls)
  end

  it "calling a method that accepts a block is yielded only once" do
    called = 0
    @logger.info do
      called += 1
      "Hello"
    end

    assert_equal 1, called, "block should be called just once"
    assert_equal [[Logger::INFO, "Hello", nil]], @log1.adds
    assert_equal [[Logger::INFO, "Hello", nil]], @log2.adds
  end

  it "calling a method that accepts a block" do
    logger = described_class.new(CustomLogger.new)

    called = false
    logger.bar do
      called = true
    end
    assert(called)
  end

  it "calling a method that accepts args" do
    logger = described_class.new(CustomLogger.new)

    assert(logger.baz("foo"))
  end

  it "calling a method that accepts kwargs" do
    logger = described_class.new(CustomLogger.new)

    assert(logger.qux(param: "foo"))
  end

  it "#dup duplicates the broadcasts" do
    logger = CustomLogger.new
    logger.level = Logger::WARN
    broadcast_logger = described_class.new(logger)

    duplicate = broadcast_logger.dup

    assert_equal Logger::WARN, duplicate.broadcasts.sole.level
    assert_not_same logger, duplicate.broadcasts.sole
    assert_same logger, broadcast_logger.broadcasts.sole
  end

  it "logging always returns true" do
    assert_equal true, @logger.info("Hello")
    assert_equal true, @logger.error("Hello")
  end

  Logger::Severity.constants.each do |level_name|
    method = level_name.downcase
    level = Logger::Severity.const_get(level_name)

    it "##{method} delegates keyword arguments to loggers" do
      logger = described_class.new(KwargsAcceptingLogger.new)

      kwargs = {foo: "bar"}
      logger.public_send(method, "Hello", **kwargs)
      assert_equal [[level, "#{kwargs.inspect} Hello", nil]], logger.broadcasts.sole.adds
    end
  end

  it "#add delegates keyword arguments to the loggers" do
    logger = described_class.new(KwargsAcceptingLogger.new)

    kwargs = {foo: "bar"}
    logger.add(Logger::INFO, "Hello", **kwargs)
    assert_equal [[Logger::INFO, "#{kwargs.inspect} Hello", nil]], logger.broadcasts.sole.adds
  end
end
