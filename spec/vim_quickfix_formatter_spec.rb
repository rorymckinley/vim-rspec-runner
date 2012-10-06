require File.join(File.dirname(__FILE__), '..', 'plugin', 'formatter', 'vim_quickfix_formatter')

describe RSpec::Core::Formatters::VimQuickfixFormatter do
  let (:backtrace) {
    [ "not_this_file.rb:100:in blah", "this_file_spec.rb:1001:in `block", "this_file_neither:20: in more_stuff"]
  }
  let (:exception) { mock(Exception, :message => "A message", :backtrace => backtrace) }
  let (:failed_example) { mock(RSpec::Core::Example, :execution_result => {:exception => exception})}
  let (:io) { mock(IO) }
  let (:formatter) { RSpec::Core::Formatters::VimQuickfixFormatter.new(io) }

  it "extends the RSpec BaseTextFormatter" do
    RSpec::Core::Formatters::VimQuickfixFormatter.should < RSpec::Core::Formatters::BaseTextFormatter
  end

  it "outputs a string formatted for use in a quickfix window" do
    io.should_receive(:puts).with("this_file_spec.rb:1001: [FAIL] A message")

    formatter.example_failed(failed_example)
  end

  it "squashes the message onto a single line" do
    exception.stub!(:message).and_return("A\nMultiline\nMessage")
    io.should_receive(:puts).with(/A Multiline Message/)

    formatter.example_failed(failed_example)
  end
end
