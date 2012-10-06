require 'rspec/core/formatters/base_text_formatter'

module RSpec
  module Core
    module Formatters
      class VimQuickfixFormatter < BaseTextFormatter
        def example_failed(example)
          message = example.execution_result[:exception].message
          backtrace = example.execution_result[:exception].backtrace

          output.puts "#{extract_path(backtrace)}: [FAIL] #{flatten(message)}"
        end

        def flatten(message)
          message.split("\n").join(" ")
        end
        private :flatten

        def extract_path(backtrace)
          calling_file = backtrace.find { |line| line =~ /^(.*_spec\.rb:.*):in/ }
          $1
        end
        private :extract_path
      end
    end
  end
end
