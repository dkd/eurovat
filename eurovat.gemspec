require File.expand_path('lib/eurovat/version')

Gem::Specification.new do |s|
	s.name = "dkd-eurovat"
	s.version = Eurovat::VERSION_STRING
  s.licenses = ['MIT']
	s.summary = "European Union VAT number utilities"
	s.email = "opensource@dkd.de"
	s.homepage = "https://github.com/dkd/eurovat"
	s.description = "A utility library for dealing with European Union VAT numbers"
	s.authors = ["Hongli Lai (http://www.phusion.nl/)", "Michael Skrynski (dkd)"]

	s.files = Dir[
		"README.markdown",
		"LICENSE.txt",
		"lib/**/*",
		"test/*"
	]
end
