require_relative 'lib/appium_twine/version'

Gem::Specification.new do |s|
  # 1.8.x is not supported
  s.required_ruby_version = '>= 1.9.3'

  s.name          = 'appium_twine'
  s.version       = Appium::Twine::VERSION
  s.date          = Appium::Twine::DATE
  s.license       = 'https://github.com/appium/appium_twine/blob/master/LICENSE'
  s.description   = s.summary = 'Appium plugin for twine that enables C# generation for use with Xamarin.Forms'
  s.description   += '.' # avoid identical warning
  s.authors       = s.email = ['code@bootstraponline.com']
  s.homepage      = 'https://github.com/appium/appium_twine'
  s.require_paths = ['lib']

  s.add_runtime_dependency 'twine', '~> 0.5.0'

  s.add_development_dependency 'appium_thor', '~> 0.0', '>= 0.0.7'

  s.files = `git ls-files`.split("\n")
end