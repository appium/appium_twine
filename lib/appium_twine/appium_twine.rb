require 'rubygems'
require 'twine'

require_relative 'formatter'
require_relative 'version'

module Appium
  module Twine
    class << self
      # Adds a single formatter to the Twine::Formatters constant.
      #
      # @param formatter [Class] new formatter to append. Example: Formatters::Foobar
      def add_formatter formatter
        target_module   = ::Twine::Formatters
        target_constant = :FORMATTERS

        return unless target_module.const_defined? target_constant

        old_value = target_module.send :remove_const, target_constant
        new_value = old_value << formatter

        target_module.send :const_set, target_constant, new_value
      end
    end
  end
end

Appium::Twine.add_formatter Twine::Formatters::Csharp