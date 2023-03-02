class UsefulFormatter
  RSpec::Core::Formatters.register self, :example_passed, :example_pending, :example_failed, :start_dump

  attr_reader :output

  def initialize(output)
    @output = output || StringIO.new
    @example_group = nil
  end

  def example_passed(_notification)
    output.print RSpec::Core::Formatters::ConsoleCodes.wrap('.', :success)
  end

  def example_pending(_notification)
    output.print RSpec::Core::Formatters::ConsoleCodes.wrap('*', :pending)
  end

  def example_failed(failure)
    output.puts failure.fully_formatted(next_failure_index)
  end

  def start_dump(_notification)
    output.puts
  end

  private

  def next_failure_index
    @next_failure_index ||= 0
    @next_failure_index += 1
  end
end
