require 'rubygems'
require 'twine'

require_relative 'formatter'
require_relative 'version'

Twine::Formatters.formatters += [Twine::Formatters::Csharp]