class EagerProgressFormatter
  ::RSpec::Core::Formaters.register self, :example_passed, :example_pending, :example_failed, :dump_summary

  attr_reader :output

  def initialize(output)
    super(output)
  end

  Color = ::RSpec::Core::Formatters::ConsoleCodes

  def example_passed(notification)
    output.print Color.wrap('.', :success)
  end

  def example_pending(notification)
    output.print Color.wrap('*', :pending)
  end

  def example_failed(notification)
    output.puts Color.wrap(failure.fully_formatted(next_failure_index), :failure)
  end

  def dump_summary(summary)
    output.puts summary.fully_formatted
  end

  private

  def next_failure_index
    @next_failure_index ||= 0
    @next_failure_index += 1
  end
end
