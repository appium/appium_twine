require 'rubygems'
require 'twine'

require_relative 'formatter'
require_relative 'version'

Twine::Formatters.register_formatter Twine::Formatters::Csharp