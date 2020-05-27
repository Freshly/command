lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "command/version"

Gem::Specification.new do |spec|
  spec.name          = "command"
  spec.version       = Command::VERSION
  spec.authors       = [ "Eric Garside", "Allen Rettberg", "Jordan Minneti" ]
  spec.email         = %w[garside@gmail.com allen.rettberg@freshly.com jordan.minneti@freshly.com]

  spec.summary       = "Define what your application does with service objects that adapt to your architecture"
  spec.description   = "A behavioral approach for building extensible business objects in Rails applications"
  spec.homepage      = "https://github.com/Freshly/command"
  spec.license       = "MIT"

  spec.files         = Dir["README.md", "LICENSE.txt", "lib/**/{*,.[a-z]*}"]
  spec.require_paths = "lib"

  spec.add_runtime_dependency "activesupport", ">= 5.2.1", "< 6.1.0"
  spec.add_runtime_dependency "spicery", ">= 0.19.2", "< 1.0"
  spec.add_runtime_dependency "flow", ">= 0.10.3", "< 1.0"
  spec.add_runtime_dependency "batch_processor", ">= 0.3.0", "< 1.0"

  spec.add_development_dependency "bundler", "~> 2.0.1"
  spec.add_development_dependency "faker", "~> 1.8"
  spec.add_development_dependency "pry-byebug", ">= 3.7.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.16"
  spec.add_development_dependency "timecop", ">= 0.9.1"

  spec.add_development_dependency "rspice", ">= 0.19.2", "< 1.0"
  spec.add_development_dependency "spicerack-styleguide", ">= 0.19.2", "< 1.0"
  spec.add_development_dependency "shoulda-matchers", "4.0.1"
end
